//
//  NoneWebSocketState.swift
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

struct NoneWebSocketState: WebSocketState {
    static func == (lhs: NoneWebSocketState, rhs: NoneWebSocketState) -> Bool {
        lhs.label == rhs.label
    }
    
    let name: WebSocketStates = .none
    let label = "…"
    let symbol = "Circle"
    let color: Color = .gray

    func primary(_ context: WebSocketContext) {

        let connecting: WebSocketStates = .connecting(
            address: context.address,
            token: context.token ?? ""
        )

        context.setState(name: connecting)
        connecting.state.auto(context)

    }
}
