//
//  WeTransferEndpoint.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Foundation

public enum WeTransferEndpoint: Endpoint {
    case rooms
    case bookRoom

    public var baseURL: URL {
        URL(string: "https://wetransfer.github.io")!
    }

    public var path: String {
        switch self {
        case .rooms:
            return "/rooms.json"

        case .bookRoom:
            return "/bookRoom.json"
        }
    }
}
