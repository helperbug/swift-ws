//
//  ErrorWebSocketState.swift
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

struct ErrorWebSocketState: WebSocketState {

    let name: WebSocketStates = .error(description: "")
    let message: String
    
    func primary(_ context: WebSocketContext) {

        context.setState(name: .none)

    }
}
