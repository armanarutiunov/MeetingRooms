// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Remote dependencies

private let NukeUI = Target.Dependency.product(name: "NukeUI", package: "Nuke")

// MARK: - Local modules

private let Cloud = Target.Dependency(stringLiteral: "Cloud")
private let Datasource = Target.Dependency(stringLiteral: "Datasource")
private let DesignSystem = Target.Dependency(stringLiteral: "DesignSystem")
private let RoomManager = Target.Dependency(stringLiteral: "RoomManager")
private let Utilities = Target.Dependency(stringLiteral: "Utilities")

// MARK: - Package

let package = Package(name: "Modules",

                      platforms: [.iOS(.v16)],

                      products: [.library(name: "DesignSystem",
                                          targets: ["DesignSystem"]),

                                 .library(name: "Rooms",
                                          targets: ["Rooms"])],

                      dependencies: [.package(url: "https://github.com/kean/Nuke", exact: Version("12.1.5"))],
    
                      targets: [.target(name: "Cloud",
                                        dependencies: [Utilities]),

                                .target(name: "Datasource"),

                                .target(name: "DesignSystem"),

                                .target(name: "RoomManager",
                                        dependencies: [Cloud, Datasource]),

                                .target(name: "Rooms",
                                        dependencies: [DesignSystem, NukeUI, RoomManager]),

                                .target(name: "Utilities"),
        
                                .testTarget(name: "ModulesTests",
                                            dependencies: [Cloud]),
    ]
)
