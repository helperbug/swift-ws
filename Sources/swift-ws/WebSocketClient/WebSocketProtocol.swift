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

public protocol WebSocketProtocol: AnyObject {

    var name: WebSocketStates { get }
    var color: Color { get }
    var label: String { get }
    var symbol: String { get }
    var stateChanged: ((WebSocketStates) -> Void)? { get }
    var onData: ((Data) -> Void)? { get }
    var onMessage: ((String) -> Void)? { get }

    init(address: String, token: String, headers: [String: String])
    
    func disconnect()
    func connect()
    func send(message: String)
}
