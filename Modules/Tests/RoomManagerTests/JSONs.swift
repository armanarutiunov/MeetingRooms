//
//  JSONs.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

@testable import RoomManager
import Foundation

let RoomJSON: [String: Any] = [
    Room.CodingKeys.name.rawValue: "Ljerka",
    Room.CodingKeys.spotsCount.rawValue: 43,
    Room.CodingKeys.imageURL.rawValue: "https://image.com"
]

let RoomsResponseJSON: [String: Any] = [
    "rooms": [RoomJSON]
]
