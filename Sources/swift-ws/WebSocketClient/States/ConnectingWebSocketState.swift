//
//  ConnectingWebSocketState.swift
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

struct ConnectingWebSocketState: WebSocketState {
    
    let name: WebSocketStates = .connecting(address: "", token: "")
    let address: String
    let token: String
    
    func auto(_ context: WebSocketContext) {
        
        guard let url = URL(string: address) else {
            context.webSocketTask = nil
            context.setState(name: .error(description: "Bad Url"))
            return
        }
        
        let config = URLSessionConfiguration.default
        if config.httpAdditionalHeaders == nil {
            config.httpAdditionalHeaders = [:]
        }
        
        context.headers.forEach { header in
            config.httpAdditionalHeaders?[header.key] = header.value
        }
        
        let urlSession = URLSession(configuration: config,
                                    delegate: context as URLSessionWebSocketDelegate,
                                    delegateQueue: OperationQueue())
        
        let webSocketTask = urlSession.webSocketTask(with: url)
        
        context.webSocketTask = webSocketTask
        
        webSocketTask.resume()
        
        let connected: WebSocketStates = .connected
        context.setState(name: connected)
        connected.state.auto(context)

    }
}
