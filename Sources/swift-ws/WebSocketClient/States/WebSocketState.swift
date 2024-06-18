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

public protocol WebSocketState {
    
    var name: WebSocketStates { get }
    
    func primary(_ context: WebSocketContext) -> Void
    func auto(_ context: WebSocketContext) -> Void
    func error(_ context: WebSocketContext) -> Void
    
    func send(_ context: WebSocketContext, data: String?) -> Void
}

extension WebSocketState {
    func primary(_ context: WebSocketContext) { fatalError() }
    func auto(_ context: WebSocketContext) { fatalError() }
    func error(_ context: WebSocketContext) { fatalError() }
    func send(_ context: WebSocketContext, data: String?) { fatalError() }
}
