// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2021",
    platforms: [.macOS(.v10_14)],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-parsing.git",
            from: "0.3.0"
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AdventOfCode2021",
            dependencies: [
                .product(name: "Parsing", package: "swift-parsing"),
                .target(name: "AdventOfCode2021Library")
            ]),
        .target(name: "AdventOfCode2021Library",
                dependencies: [
                    .product(name: "Parsing", package: "swift-parsing")
                ],
                resources: [
                    .process("Inputs")
                ]),
        .testTarget(
            name: "AdventOfCode2021Tests",
            dependencies: ["AdventOfCode2021", "AdventOfCode2021Library"]),
    ]
)
