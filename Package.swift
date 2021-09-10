// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "Common",
            targets: [
                "Common"
            ]
        )
    ],
    dependencies: [
        // Empty.
    ],
    targets: [
        .target(
            name: "Common"
        )
    ]
)
