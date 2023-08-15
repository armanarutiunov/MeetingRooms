//
//  RoomTests.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

@testable import RoomManager
import Utilities
import XCTest

final class RoomTests: XCTestCase {

    // MARK: - Decoding

    func testDecode() {
        let room: Room? = decodeFromJSON(json: RoomJSON)

        XCTAssertNotNil(room, "Room failed to parse")
        XCTAssertEqual(room?.name, "Ljerka")
        XCTAssertEqual(room?.spotsCount, 43)
        XCTAssertEqual(room?.imageURL, URL(string: "https://image.com"))
    }

    func testDecodeWithEmptyThumbnail() {
        var json = RoomJSON
        json.removeValue(forKey: Room.CodingKeys.imageURL.rawValue)

        let room: Room? = decodeFromJSON(json: json)

        XCTAssertNotNil(room, "Room failed to parse")
        XCTAssertEqual(room?.name, "Ljerka")
        XCTAssertEqual(room?.spotsCount, 43)
        XCTAssertNil(room?.imageURL)
    }

    // MARK: - Encoding

    func testEncode() {
        let room = Room.mock(imageURL: URL(string: "https://image.com"))
        let roomJSON = encodeToJSON(object: room)

        XCTAssertNotNil(roomJSON)
        XCTAssertEqual(roomJSON?[Room.CodingKeys.name.rawValue] as? String, room.name)
        XCTAssertEqual(roomJSON?[Room.CodingKeys.spotsCount.rawValue] as? Int, room.spotsCount)
        XCTAssertEqual(roomJSON?[Room.CodingKeys.imageURL.rawValue] as? String, room.imageURL?.absoluteString)
    }
}
