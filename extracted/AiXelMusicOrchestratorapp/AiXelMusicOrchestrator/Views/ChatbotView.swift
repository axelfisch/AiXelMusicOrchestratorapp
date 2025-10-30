//
//  ChatbotView.swift
//  AiXelMusicOrchestrator
//
//  Created by Manus AI on 30/01/2025.
//  This SwiftUI view presents a simple chat interface for interacting
//  with the Aïxel Music Orchestrator GPT. It allows the user to type
//  questions or commands related to composition, orchestration or any
//  other topic and displays the conversation history. The view relies
//  on a ChatManager environment object to handle network requests.

import SwiftUI

/// The main chat interface displayed in the application. It shows a
/// scrollable list of previous messages and a text field with a send
/// button at the bottom. Messages from the user are right‑aligned,
/// while assistant responses appear on the left.
struct ChatbotView: View {
    @EnvironmentObject var chatManager: ChatManager
    @State private var currentInput: String = ""
    @FocusState private var isInputFocused: Bool

    var body: some View {
        VStack(spacing: 8) {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(chatManager.messages.filter { $0.role != "system" }) { message in
                            messageBubble(for: message)
                                .padding(.horizontal)
                                .id(message.id)
                        }
                    }
                    .padding(.vertical)
                }
                .onChange(of: chatManager.messages.count) { _ in
                    // Scroll to the bottom when a new message is added.
                    if let lastID = chatManager.messages.last?.id {
                        withAnimation { proxy.scrollTo(lastID, anchor: .bottom) }
                    }
                }
            }
            Divider()
            HStack {
                TextField("Écris ici ta question...", text: $currentInput, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .focused($isInputFocused)
                    .onSubmit(sendCurrentInput)
                Button(action: sendCurrentInput) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(currentInput.trimmingCharacters(in: .whitespaces).isEmpty ? .gray : .blue)
                }
                .disabled(currentInput.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .navigationTitle("Chatbot")
        .onAppear {
            // Optionally load a welcome message the first time the chat opens.
            if chatManager.messages.isEmpty {
                let welcome = ChatMessage(role: "assistant", content: "Bienvenue ! Pose-moi des questions sur la composition ou l'orchestration.")
                chatManager.messages.append(welcome)
            }
        }
    }

    /// Formats a chat bubble for a given message. User messages are
    /// aligned to the trailing edge with a blue background, while
    /// assistant messages are aligned to the leading edge with a gray
    /// background.
    @ViewBuilder
    private func messageBubble(for message: ChatMessage) -> some View {
        HStack {
            if message.role == "assistant" {
                bubble(text: message.content, color: Color(UIColor.systemGray5), alignment: .leading)
                Spacer()
            } else {
                Spacer()
                bubble(text: message.content, color: Color.blue.opacity(0.2), alignment: .trailing)
            }
        }
    }

    /// Generates a styled bubble view containing the specified text.
    private func bubble(text: String, color: Color, alignment: HorizontalAlignment) -> some View {
        Text(text)
            .padding(10)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: alignment)
    }

    /// Sends the current input string as a chat message and clears the
    /// text field. This function is called when the user taps the send
    /// button or presses return.
    private func sendCurrentInput() {
        let message = currentInput
        currentInput = ""
        isInputFocused = false
        Task {
            await chatManager.sendMessage(message)
        }
    }
}

// MARK: - Preview

#Preview {
    let manager = ChatManager(apiKey: "sk-REPLACE_WITH_YOUR_KEY")
    manager.messages = [
        ChatMessage(role: "assistant", content: "Bonjour, comment puis-je t'aider aujourd'hui ?"),
        ChatMessage(role: "user", content: "Génère une progression AABA en Sol majeur."),
        ChatMessage(role: "assistant", content: "Voici une progression typique : Gmaj7 | Cmaj7 | D7 | Gmaj7...")
    ]
    return NavigationStack {
        ChatbotView()
            .environmentObject(manager)
    }
}