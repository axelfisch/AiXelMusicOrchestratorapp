//
//  ChatManager.swift
//  AiXelMusicOrchestrator
//
//  Created by Manus AI on 30/01/2025.
//  This manager provides a simple interface to the OpenAI Chat API. It
//  stores a history of messages and sends new prompts to the API. The
//  actual API key must be supplied by the end user at runtime via
//  environment variables or secure storage. This file does not include
//  any secret credentials.

import Foundation
import Combine

/// Represents a single chat message exchanged with the GPT backend.
public struct ChatMessage: Identifiable, Codable {
    public let id = UUID()
    public let role: String
    public let content: String

    public init(role: String, content: String) {
        self.role = role
        self.content = content
    }
}

/// Observable object responsible for managing the chat history and
/// performing network requests to the OpenAI API. This class uses
/// Combine to publish updates whenever the messages array changes.
@MainActor
public final class ChatManager: ObservableObject {
    /// Published array of messages displayed in the chat interface.
    @Published public private(set) var messages: [ChatMessage] = []
    /// The current asynchronous network task, if any.
    private var currentTask: URLSessionDataTask?
    /// Your OpenAI API key. Provide this through a secure mechanism.
    private let apiKey: String

    /// A system prompt that defines the stylistic constraints of the
    /// assistant. This message is sent as the first element of the
    /// conversation to guide the model towards Axel Fisch's harmonic
    /// language: progressions with add9, sus2, sus4, maj7(11+), min9,
    /// 13(b9), 7(9+5+), min(7+) and smooth modulations【122488281204925†L8-L13】.
    private let systemPrompt: String = "Tu es un assistant spécialisé en musique jazz‑pop dans le style d'Axel Fisch. Utilise des accords tels que add9, sus2, sus4, maj7(11+), min9, 13(b9), 7(9+5+), min(7+), favorise les enchaînements Approche→Tension→Résolution et propose des modulations douces entre tonalités voisines. Réponds en français."

    /// The file name used to persist conversation history.
    private let historyFileName = "chat_history.json"

    /// Initializes the chat manager with an API key. The key should be
    /// stored securely, for example in the iOS keychain or as a
    /// configuration setting supplied at runtime. Hard‑coding the key is
    /// discouraged for production builds. During initialization the
    /// existing conversation history is loaded from disk.
    /// - Parameter apiKey: A valid OpenAI API key string.
    public init(apiKey: String) {
        self.apiKey = apiKey
        // Attempt to load previous messages from disk. If none are found,
        // seed the conversation with the system prompt.
        if let stored = try? loadMessagesFromDisk(), !stored.isEmpty {
            self.messages = stored
        } else {
            // The system prompt itself is not displayed in the UI but is
            // stored internally as the first message with role "system".
            let systemMessage = ChatMessage(role: "system", content: systemPrompt)
            self.messages = [systemMessage]
        }
    }

    /// Sends a user message to the chat and asynchronously requests a
    /// response from the OpenAI API. The assistant's reply will be
    /// appended to the messages array when the request completes.
    /// - Parameter text: The user's message content.
    public func sendMessage(_ text: String) async {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        // Append the user's message to the history.
        let userMessage = ChatMessage(role: "user", content: trimmed)
        messages.append(userMessage)

        // Persist the updated conversation to disk.
        saveMessagesToDisk()

        do {
            let reply = try await requestChatCompletion()
            let assistantMessage = ChatMessage(role: "assistant", content: reply)
            messages.append(assistantMessage)
            saveMessagesToDisk()
        } catch {
            // Append an error message if the request fails.
            let errorMessage = ChatMessage(role: "assistant", content: "Erreur: \(error.localizedDescription)")
            messages.append(errorMessage)
            saveMessagesToDisk()
        }
    }

    /// Builds and executes the HTTP request to the OpenAI chat completions
    /// endpoint. The request body includes the entire message history and
    /// targets GPT‑4 by default. You can customise parameters such as
    /// temperature or model name as needed. The response is parsed and
    /// returned as a single string containing the assistant's reply.
    /// - Throws: An error if the network request or decoding fails.
    /// - Returns: The assistant's reply text.
    private func requestChatCompletion() async throws -> String {
        // Construct the request URL.
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Prepare the request body with the message history.
        // Include the conversation history, preserving the system prompt at
        // the beginning. Only send messages that have a role and content.
        let chatHistory = messages.map { ["role": $0.role, "content": $0.content] }
        let payload: [String: Any] = [
            "model": "gpt-4",
            "messages": chatHistory,
            // Temperature can be adjusted to control creativity.
            "temperature": 0.7
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])

        // Execute the network request.
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw NSError(domain: "ChatManager", code: code, userInfo: [NSLocalizedDescriptionKey: "Échec de la requête API (code \(code))"])
        }
        // Decode the JSON response.
        struct APIResponse: Decodable {
            struct Choice: Decodable { let message: ChatMessageContent }
            struct ChatMessageContent: Decodable { let role: String; let content: String }
            let choices: [Choice]
        }
        let decoder = JSONDecoder()
        let apiResponse = try decoder.decode(APIResponse.self, from: data)
        guard let first = apiResponse.choices.first else {
            throw NSError(domain: "ChatManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Aucune réponse du modèle"])
        }
        return first.message.content.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // MARK: - Persistence

    /// Computes the URL for the history file in the application's
    /// documents directory.
    private var historyFileURL: URL? {
        do {
            let docs = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            return docs.appendingPathComponent(historyFileName)
        } catch {
            return nil
        }
    }

    /// Saves the current messages array to disk as JSON. Errors are
    /// ignored silently because persistence is non‑critical.
    private func saveMessagesToDisk() {
        guard let url = historyFileURL else { return }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(messages)
            try data.write(to: url)
        } catch {
            // We deliberately ignore errors here to avoid crashing the UI.
        }
    }

    /// Loads the conversation history from disk. If the file cannot be
    /// decoded, an empty array is returned. Only messages with a role
    /// other than "system" will appear in the UI.
    private func loadMessagesFromDisk() throws -> [ChatMessage] {
        guard let url = historyFileURL else { return [] }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let stored = try decoder.decode([ChatMessage].self, from: data)
        return stored
    }
}