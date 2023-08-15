//
//  BookRoomResponseTests.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

@testable import RoomManager
import Utilities
import XCTest

final class BookRoomResponseTests: XCTestCase {

    func testDecode() {
        let response: BookRoomResponse? = decodeFromJSON(json: BookRoomResponseJSON)

        XCTAssertNotNil(response)
        XCTAssertEqual(response?.isSuccess, true)
    }
}
