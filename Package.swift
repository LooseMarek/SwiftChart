// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftChart",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "SwiftChart",
            targets: ["SwiftChart"])
    ],
    targets: [
        .target(
            name: "SwiftChart",
            path: "Source",
            exclude: []
        )
    ],
    swiftLanguageVersions: [.v5]
)
