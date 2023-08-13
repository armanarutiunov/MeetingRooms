// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let Cloud = Target.Dependency(stringLiteral: "Cloud")
private let RoomManager = Target.Dependency(stringLiteral: "RoomManager")
private let Utilities = Target.Dependency(stringLiteral: "Utilities")

let package = Package(name: "Modules",

                      platforms: [.iOS(.v16)],

                      products: [.library(name: "Rooms",
                                          targets: ["Rooms"])],
    
                      targets: [.target(name: "Cloud",
                                        dependencies: [Utilities]),

                                .target(name: "RoomManager",
                                        dependencies: [Cloud]),

                                .target(name: "Rooms",
                                        dependencies: [RoomManager]),

                                .target(name: "Utilities"),
        
                                .testTarget(name: "ModulesTests",
                                            dependencies: [Cloud]),
    ]
)
