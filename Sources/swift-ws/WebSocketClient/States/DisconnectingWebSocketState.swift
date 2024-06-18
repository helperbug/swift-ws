//
//  DisconnectingWebSocketState.swift
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

struct DisconnectingWebSocketState: WebSocketState {

    let name: WebSocketStates = .disconnecting

    func auto(_ context: WebSocketContext) {

        if let webSocketTask = context.webSocketTask {

            webSocketTask.cancel(with: .goingAway, reason: nil)

        }

    }
}
