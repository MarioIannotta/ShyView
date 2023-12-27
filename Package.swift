// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "ShyView",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_15),
        .macCatalyst(.v13),
        .watchOS(.v6),
        .tvOS(.v12),
    ],
    products: [
        .library(
            name: "ShyView",
            targets: ["ShyView"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.11.1"
        )
    ],
    targets: [
        .target(name: "ShyView"),
        .testTarget(
            name: "ShyViewTests",
            dependencies: [
                .target(name: "ShyView"),
                .product(
                    name: "SnapshotTesting",
                    package: "swift-snapshot-testing"
                )
            ]
        )
    ]
)
