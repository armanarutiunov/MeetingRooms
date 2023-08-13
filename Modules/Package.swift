// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let NukeUI = Target.Dependency.product(name: "NukeUI", package: "Nuke")

private let Cloud = Target.Dependency(stringLiteral: "Cloud")
private let RoomManager = Target.Dependency(stringLiteral: "RoomManager")
private let Utilities = Target.Dependency(stringLiteral: "Utilities")

let package = Package(name: "Modules",

                      platforms: [.iOS(.v16)],

                      products: [.library(name: "Rooms",
                                          targets: ["Rooms"])],

                      dependencies: [.package(url: "https://github.com/kean/Nuke", exact: Version("12.1.5"))],
    
                      targets: [.target(name: "Cloud",
                                        dependencies: [Utilities]),

                                .target(name: "RoomManager",
                                        dependencies: [Cloud]),

                                .target(name: "Rooms",
                                        dependencies: [NukeUI, RoomManager]),

                                .target(name: "Utilities"),
        
                                .testTarget(name: "ModulesTests",
                                            dependencies: [Cloud]),
    ]
)
