//
//  WebSocketContext.swift
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

public class WebSocketContext: NSObject, WebSocketProtocol, ObservableObject {
    
    var webSocketTask: URLSessionWebSocketTask? = nil
    let address: String
    let token: String
    let headers: [String: String]
    
    public var stateChanged: ((WebSocketStates) -> Void)? = nil
    public var onData: ((Data) -> Void)? = nil
    public var onMessage: ((String) -> Void)? = nil
    
    @Published private var state: WebSocketState
    
    public var color: Color {
        
        name.color
        
    }
    
    public var label: String {
        
        name.label
        
    }
    
    public var symbol: String {
        
        name.symbol
        
    }
    
    public var name: WebSocketStates {
        
        state.name
        
    }
    
    static public var blank: WebSocketContext {
        
        .init(address: "", token: "", headers: [:])
        
    }
    
    required public init(
        address: String,
        token: String,
        headers: [String: String]
    ) {
        
        self.address = address
        self.token = token
        self.headers = headers
        
        state = NoneWebSocketState()
        
        super.init()
        
    }
    
    public func disconnect() {
        
        if name == .connected {
            
            state.primary(self)
            
        }
    }
    
    public func connect() {
        
        if name == .none {
            
            state.primary(self)
            
        }
        
    }
    
    public func send(message: String) {
        
        if name == .connected {
            
            state.send(self, data: message)
            
        }
        
    }
    
    func setState(name: WebSocketStates) {
        
        state = name.state
        
        if let stateChanged {
            
            stateChanged(name)
            
        }
        
    }
    
}

extension WebSocketContext: URLSessionWebSocketDelegate {
    
    public func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocol: String?
    ) {
        
        guard let headers = session.configuration.httpAdditionalHeaders else {

            return

        }
        
        headers.forEach { header in
            
            print("\(header.key): \(header.value)")
            
        }
        
    }
    
    public func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {
        
        setState(name: .none)
        self.webSocketTask = nil
        
    }
}
