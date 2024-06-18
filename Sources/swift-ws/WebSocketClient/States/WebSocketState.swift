//
//  WebSocketState.swift
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

/// Protocol defining the state of the WebSocket.
public protocol WebSocketState {
    
    /// The current state represented as a `WebSocketStates` enum.
    var name: WebSocketStates { get }
    
    /// Handles the primary action for the WebSocket context.
    /// - Parameter context: The WebSocket context.
    func primary(_ context: WebSocketContext) -> Void
    
    /// Handles automatic actions for the WebSocket context.
    /// - Parameter context: The WebSocket context.
    func auto(_ context: WebSocketContext) -> Void
    
    /// Handles error actions for the WebSocket context.
    /// - Parameter context: The WebSocket context.
    func error(_ context: WebSocketContext) -> Void
    
    /// Sends data over the WebSocket.
    /// - Parameters:
    ///   - context: The WebSocket context that is going to sent the data.
    ///   - data: The data to send.
    func send(_ context: WebSocketContext, data: String) -> Void
}

extension WebSocketState {

    func primary(_ context: WebSocketContext) {

        fatalError()

    }
    
    func auto(_ context: WebSocketContext) {

        fatalError()

    }
    
    func error(_ context: WebSocketContext) {

        fatalError()

    }
    
    func send(_ context: WebSocketContext, data: String) {

        fatalError()

    }
    
}
