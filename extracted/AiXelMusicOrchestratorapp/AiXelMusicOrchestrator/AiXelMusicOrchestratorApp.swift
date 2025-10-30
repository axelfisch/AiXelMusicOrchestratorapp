//
//  AiXelMusicOrchestratorApp.swift
//  AiXelMusicOrchestrator
//
//  Created by Manus AI on 30/01/2025.
//

import SwiftUI
import AudioKit

@main
struct AiXelMusicOrchestratorApp: App {
    @StateObject private var audioManager = AudioManager.shared
    @StateObject private var orchestrationManager = OrchestrationManager()
    // Instantiate the chat manager. The API key is read from an
    // environment variable named `OPENAI_API_KEY`. You should set
    // this variable in your scheme or at runtime to a valid OpenAI
    // token. If the key is missing, the chat interface will still
    // display messages but no network requests will succeed.
    @StateObject private var chatManager: ChatManager = {
        let key = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
        return ChatManager(apiKey: key)
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
                .environmentObject(orchestrationManager)
                .environmentObject(chatManager)
                .onAppear {
                    setupAudio()
                }
                .onDisappear {
                    audioManager.stop()
                }
        }
    }
    
    private func setupAudio() {
        audioManager.setup()
    }
}

