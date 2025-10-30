//
//  ChatManagerTests.swift
//  AiXelMusicOrchestratorTests
//
//  Created by Manus AI on 30/01/2025.
//  These unit tests verify basic behaviour of the ChatManager, ensuring
//  that a system prompt is present at initialization and that sending
//  a message appends both the user input and an assistant response or
//  error placeholder.

import XCTest
@testable import AiXelMusicOrchestrator

final class ChatManagerTests: XCTestCase {

    /// Ensure that the first message in a new ChatManager instance is
    /// always the system prompt.
    func testSystemPromptIsIncluded() {
        let cm = ChatManager(apiKey: "")
        XCTAssertFalse(cm.messages.isEmpty, "Messages should not be empty after initialization")
        XCTAssertEqual(cm.messages.first?.role, "system", "The first message should be the system prompt")
    }

    /// Verify that sending a message results in at least two new
    /// messages: the user input and either an assistant reply or an
    /// error message. This test uses an invalid API key so the reply
    /// will be an error, exercising the error path.
    func testSendMessageAppendsMessages() async {
        let cm = ChatManager(apiKey: "invalid-key")
        let initialCount = cm.messages.count
        await cm.sendMessage("Test message")
        let newCount = cm.messages.count
        XCTAssertGreaterThanOrEqual(newCount, initialCount + 2, "Sending a message should append at least two messages to the history")
        // The last message should be from the assistant
        XCTAssertEqual(cm.messages.last?.role, "assistant")
    }
}