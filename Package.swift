// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "alice",
    dependencies: [
        .package(url: "https://github.com/t089/swift-argument-parser.git", branch: "foundationless")
    ],
    targets: [
        .executableTarget(
            name: "alice",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")])
    ]
)