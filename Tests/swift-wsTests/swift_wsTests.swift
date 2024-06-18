import XCTest
@testable import SwiftWs

final class swift_wsTests: XCTestCase {
    
    func testEcho() throws {
        
        let expectation = self.expectation(description: "WebSocket connection")
        let vector = "Test String"
        let context = WebSocketContext(address: "wss://echo.websocket.org/", token: "", headers: [:])
        
        context.stateChanged = { state in

            if state == .connected {
                
                context.send(message: vector)
                
            }

        }
        
        context.onMessage = { message in

            if message == vector {

                expectation.fulfill()

            }

        }
        
        context.connect()
        
        wait(for: [expectation], timeout: 5)
        
    }
    
}
