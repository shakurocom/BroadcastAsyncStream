// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BroadcastAsyncStream",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "BroadcastAsyncStream",
            targets: ["BroadcastAsyncStream"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "BroadcastAsyncStream",
            dependencies: []),
        .testTarget(
            name: "BroadcastAsyncStreamTests",
            dependencies: ["BroadcastAsyncStream"]),
    ]
)
