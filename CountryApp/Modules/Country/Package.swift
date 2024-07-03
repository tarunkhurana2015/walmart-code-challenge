// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Country",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Country",
            targets: ["Country"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.2.2"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.0"),
        .package(name: "Network", path: "../Network")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Country",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
                .product(name: "Network", package: "Network")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Country"]),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Country"]),
        .testTarget(
            name: "DataTests",
            dependencies: ["Country"]),
    ]
)
