//
//  WebSocketStateView.swift
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

public struct WebSocketStateView: View {
    @StateObject var context: WebSocketContext = .blank
    @State var address: String = "https://echo.websocket.org/"
    @State var token: String = ""

    public init() { }
    
    public var body: some View {
        
        VStack {

            if context.address.isEmpty {
                
                socketForm
                
            }
            
            buttons
            
        }
        
    }
    
    var socketForm: some View {
        
        VStack {

            HStack {
                
                Label("Server", systemImage: "globe")
                TextField("Web Socket Server", text: $address)
                    .padding(.leading, 20)
                
            }
            
            HStack {
                
                Label("Token", systemImage: "ticket")
                TextField("Token", text: $token)
                    .padding(.leading, 20)
                
            }

        }
        
    }
    
    var buttons: some View {

        Group {
            
            Label(
                
                title: {
                    Text(context.label)
                },
                
                icon: {
                    Image(systemName: context.symbol)
                        .foregroundStyle(context.color.gradient)
                }
                
            )
            
            if context.name == .connected {
                
                Button {
                    
                    context.disconnect()
                    
                } label: {
                    
                    Text("Disconnect")
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                
            } else {
                
                Button {
                    
                    context.connect()
                    
                } label: {
                    
                    Text("Connect")
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                
            }

        }

    }
    
}

#Preview {
    
    WebSocketStateView()
    
}

