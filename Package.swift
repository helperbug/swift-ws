//  swift-tools-version: 5.10
//
//  swift-srt
//
//  Created by Ben Waidhofer on 6/17/2024.
//
//  This source file is part of the swift-ws open source project
//
//  Licensed under the MIT License. You may obtain a copy of the License at
//  https://opensource.org/licenses/MIT
//

import PackageDescription

let package = Package(
    
    name: "SwiftWs",
    
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10)
    ],
    
    products: [
        
        .library(
            name: "SwiftWs",
            targets: ["SwiftWs"]),
        
    ],
    
    targets: [
        
        .target(
            name: "SwiftWs"),
        
            .testTarget(
                name: "SwiftWsTests",
                dependencies: ["SwiftWs"]),
        
    ]
    
)

