//
//  Room.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Foundation

public struct Room: Identifiable, Decodable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case name
        case spotsCount = "spots"
        case imageURL = "thumbnail"
    }

    // MARK: - Properties

    public var id: Int {
        hashValue
    }

    public let name: String

    public let spotsCount: Int

    public let imageURL: URL?

    // MARK: - Life Cycle

    public init(name: String, spotsCount: Int, imageURL: URL?) {
        self.name = name
        self.spotsCount = spotsCount
        self.imageURL = imageURL
    }

}

// MARK: - Hashable
extension Room: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(spotsCount)
        hasher.combine(imageURL)
    }
}
