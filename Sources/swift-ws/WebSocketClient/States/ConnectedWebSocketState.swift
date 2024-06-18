//
//  ConnectedWebSocketState.swift
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

class ConnectedWebSocketState: WebSocketState {
    
    let name: WebSocketStates = .connected
    
    func primary(_ context: WebSocketContext) {
        if let webSocketTask = context.webSocketTask {
            webSocketTask.cancel(with: .goingAway, reason: nil)
            context.setState(name: .none)
        }
    }
    
    func auto(_ context: WebSocketContext) {
        
        if let webSocketTask = context.webSocketTask {
            
            receive(webSocketTask: webSocketTask, context: context)
            ping(webSocketTask)
            
        }
        
    }
    
    private func ping(_ webSocket: URLSessionWebSocketTask) {
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 30) {
            if webSocket.closeCode == .invalid {
                webSocket.sendPing { error in
                }
                self.ping(webSocket)
            }
        }
    }
    
    func send(_ context: WebSocketContext, data: String) {
        
        let message = URLSessionWebSocketTask.Message.string(data)
        
        if let webSocket = context.webSocketTask {
            webSocket.send(message) { error in
                if let error = error {
                    print("WebSocket sending error: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    func receive(webSocketTask: URLSessionWebSocketTask, context: WebSocketContext) {
        
        Task(priority: .userInitiated) {
            var operational = true
            
            while operational && webSocketTask.closeCode == .invalid {
                do {
                    
                    switch try await webSocketTask.receive() {
                        
                    case .string(let data):
                        
                        handleReceive(context, data)
                        
                    case .data(let data):
                        
                        if let payload = String(data: data, encoding: .utf8) {
                            
                            handleReceive(context, payload)
                            
                        }
                        
                    default:
                        break
                    }
                    
                } catch {
                    operational = false
                    print("fail \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func handleReceive(_ context: WebSocketContext, _ payload: String) {

        if let onMessage = context.onMessage {
            
            onMessage(payload)
            
        }
        
    }
    
}
