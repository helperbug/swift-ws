//
//  AuthenticatingWebSocketState.swift
//  swift-ws
//
//  Created by Ben Waidhofer on 6/17/2024.
//
//  This source file is part of the swift-ws open source project
//
//  Licensed under the MIT License. You may obtain a copy of the License at
//  https://opensource.org/licenses/MIT
//

import SwiftUI

struct AuthenticatingWebSocketState: WebSocketState {
    static func == (lhs: AuthenticatingWebSocketState, rhs: AuthenticatingWebSocketState) -> Bool {
        lhs.label == rhs.label
    }
    
    let token: String
    let name: WebSocketStates = .authenticating(token: "")
    let label = "Authenticating…"
    let symbol = "Circle"
    let color: Color = .gray
    
    func auto(_ context: WebSocketContext) {
        
        if let webSocketTask = context.webSocketTask {

            receive(webSocketTask: webSocketTask, context: context)
            webSocketTask.send(.string("\(context.token)")) { _ in }

        }

    }
    
    func receive(webSocketTask: URLSessionWebSocketTask, context: WebSocketContext) {
        Task(priority: .userInitiated) {
            do {
                
                switch try await webSocketTask.receive() {
                    
                case .string(let message):
                    
                    if let onMessage = context.onMessage {

                        onMessage(message)

                    }

                    let connected: WebSocketStates = .connected
                    context.setState(name: connected)
                    connected.state.auto(context)

                case .data(let data):

                    if let onData = context.onData {

                        onData(data)

                    }

                    let connected: WebSocketStates = .connected
                    context.setState(name: connected)
                    connected.state.auto(context)

                @unknown default:

                    fatalError()

                }

            } catch {

                context.setState(name: .error(description: error.localizedDescription))

            }
        }
    }
}
