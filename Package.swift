// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "ShyView",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_10),
        .tvOS(.v10),
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
