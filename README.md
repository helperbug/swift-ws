# SwiftWs

SwiftWs brings an easy-to-use wrapper around `URLSessionWebSocketTask` written in Swift. It includes support for HTTP headers for additional parameter passing and allows easy connection using a token. The library provides callbacks for state changes and data arrival, and includes methods for sending messages and disconnecting.

- Uses a state machine pattern similar to `URLSessionWebSocketTask`
- Easy connection with token support
- Supports HTTP headers during initial connection for additional parameters
- Provides updates on state changes
- Handles data arrival notifications
- Includes methods to send messages
- Allows disconnection from the WebSocket server

## Documentation

For detailed documentation, please visit [Swift-WS Documentation](https://helperbug.github.io).

## Image

![WebSocket States](WebSocketStates.png)

## License

Swift-WS is released under the MIT License. See [LICENSE](LICENSE) for details.
