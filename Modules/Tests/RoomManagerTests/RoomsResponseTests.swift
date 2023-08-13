//
//  RoomsResponseTests.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

@testable import RoomManager
import Utilities
import XCTest

final class RoomsResponseTests: XCTestCase {

    func testDecode() {
        let response: RoomsResponse? = decodeFromJSON(json: RoomsResponseJSON)
        let expectedRooms = [Room(name: "Ljerka", spotsCount: 43, imageURL: URL(string: "https://image.com"))]

        XCTAssertNotNil(response)
        XCTAssertEqual(response?.rooms, expectedRooms)
    }
}

