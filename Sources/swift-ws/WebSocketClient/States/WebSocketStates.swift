//
//  WebSocketStates.swift
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

/// The finite states for the WebSocket state machine. Each state represents has specific exit conditions that lead to other states.
public enum WebSocketStates {
    /// If there is a token an extra state transition will wait for the first packet to return
    case authenticating(token: String)
    /// Waiting for the server to resolve
    case connecting(address: String, token: String)
    /// Server is valid and the connection is ready to send and receive data
    case connected
    /// Transitioning to none, clean-up during this state
    case disconnecting
    /// Something went wrong, terminal state
    case error(description: String)
    /// Start and end state
    case none
    
    var state: any WebSocketState {
        switch self {
        case .authenticating(let token):
            return AuthenticatingWebSocketState(token: token)
        case .connecting(let address, let token):
            return ConnectingWebSocketState(address: address, token: token)
        case .connected:
            return ConnectedWebSocketState()
        case .disconnecting:
            return DisconnectingWebSocketState()
        case .error(let description):
            return ErrorWebSocketState(message: description)
        case .none:
            return NoneWebSocketState()
        }
    }
}

extension WebSocketStates: Equatable {
    
    public static func == (lhs: WebSocketStates, rhs: WebSocketStates) -> Bool {
        return lhs.id == rhs.id
    }
    
    var color: Color {
        switch self {
        case .authenticating:
            return .blue
        case .connecting:
            return .yellow
        case .connected:
            return .green
        case .disconnecting:
            return .orange
        case .error:
            return .red
        case .none:
            return .purple
        }
    }

    var id: Int {
        switch self {
        case .authenticating:
            return 1
        case .connecting:
            return 2
        case .connected:
            return 3
        case .disconnecting:
            return 4
        case .error:
            return 5
        case .none:
            return 0
        }
    }
    
    var label: String {
        switch self {
        case .authenticating:
            return "Authenticating…"
        case .connecting:
            return "Connecting…"
        case .connected:
            return "Connected"
        case .disconnecting:
            return "Disconnected"
        case .error:
            return "Error"
        case .none:
            return "…"
        }
    }
    
    var symbol: String {
        switch self {
        case .authenticating:
            return "lock.shield"
        case .connecting:
            return "arrow.right.circle"
        case .connected:
            return "checkmark.circle"
        case .disconnecting:
            return "xmark.circle"
        case .error:
            return "exclamationmark.triangle"
        case .none:
            return "questionmark.circle"
        }
    }
    
}
