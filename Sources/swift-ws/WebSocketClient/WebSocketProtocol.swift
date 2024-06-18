//
//  WebSocketProtocol.swift
//  swift-ws
//
//  Created by Ben Waidhofer on 6/17/2024.
//
//  This source file is part of the swift-ws open source project
//
//  Licensed under the MIT License. You may obtain a copy of the License at
//  https://opensource.org/licenses/MIT
//

import Foundation
import SwiftUI

/// Protocol defining the WebSocket context for managing connections and state.
public protocol WebSocketProtocol: AnyObject {

    /// Current WebSocket state that was delivered on last ``stateChanged``
    var name: WebSocketStates { get }

    /// Color representing the current state
    var color: Color { get }

    /// Label describing the current state
    var label: String { get }

    /// SF Symbol representing the current state
    var symbol: String { get }

    /// Callback for state changes
    var stateChanged: ((WebSocketStates) -> Void)? { get }

    /// Callback for receiving data
    var onData: ((Data) -> Void)? { get }

    /// Callback for receiving messages
    var onMessage: ((String) -> Void)? { get }

    /// Initializes a new WebSocket context.
    /// - Parameters:
    ///   - address: The WebSocket server address
    ///   - token: Optional authentication token
    ///   - headers: Additional headers for the WebSocket connection
    init(address: String, token: String?, headers: [String: String])
    
    /// Disconnects the WebSocket
    func disconnect()

    /// Connects the WebSocket using address and headers if present
    func connect()

    /// Sends a message over the WebSocket
    /// - Parameter message: The message to send
    func send(message: String)
}
