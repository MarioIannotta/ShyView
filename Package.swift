// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "ShyView",
    products: [
        .library(
            name: "ShyView",
            targets: ["ShyView"]
        ),
    ],
    targets: [
        .target(name: "ShyView")
    ]
)
