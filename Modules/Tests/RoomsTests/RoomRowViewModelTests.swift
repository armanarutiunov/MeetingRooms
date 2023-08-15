//
//  RoomRowViewModelTests.swift
//  
//
//  Created by Arman Arutiunov on 14/08/2023.
//

import RoomManager
@testable import Rooms
import XCTest

@MainActor
final class RoomRowViewModelTests: XCTestCase {

    func testRoomRow() {
        let imageURL = URL(string: "https://image.com")
        let room = Room.mock(imageURL: imageURL)
        let viewModel = RoomRowViewModel(room: room, onButtonTap: {})

        XCTAssertEqual(viewModel.id, room)
        XCTAssertEqual(viewModel.title, room.name)
        XCTAssertEqual(viewModel.subtitle, "\(room.spotsCount) spots remaining")
        XCTAssertEqual(viewModel.a11yImageLabel, "Room \(room.name)")
        XCTAssertEqual(viewModel.a11yImageHint, "\(room.spotsCount) spots remaining")
        XCTAssertEqual(viewModel.isButtonDisabled, false)
        XCTAssertEqual(viewModel.a11yButtonHint, "Lets you book room \(room.name)")
        XCTAssertEqual(viewModel.imageURL, imageURL)
    }

    func testRoomRowWithEmptyThumbnail() {
        let room = Room.mock()
        let viewModel = RoomRowViewModel(room: room, onButtonTap: {})

        XCTAssertEqual(viewModel.id, room)
        XCTAssertEqual(viewModel.title, room.name)
        XCTAssertEqual(viewModel.subtitle, "\(room.spotsCount) spots remaining")
        XCTAssertEqual(viewModel.a11yImageLabel, "Room \(room.name)")
        XCTAssertEqual(viewModel.a11yImageHint, "\(room.spotsCount) spots remaining")
        XCTAssertEqual(viewModel.isButtonDisabled, false)
        XCTAssertEqual(viewModel.a11yButtonHint, "Lets you book room \(room.name)")
        XCTAssertNil(viewModel.imageURL)
    }

    func testRoomWith1SpotLeft() {
        let room = Room.mock(spotsCount: 1)
        let viewModel = RoomRowViewModel(room: room, onButtonTap: {})

        XCTAssertEqual(viewModel.id, room)
        XCTAssertEqual(viewModel.title, room.name)
        XCTAssertEqual(viewModel.subtitle, "1 spot remaining")
        XCTAssertEqual(viewModel.a11yImageLabel, "Room \(room.name)")
        XCTAssertEqual(viewModel.a11yImageHint, "1 spot remaining")
        XCTAssertEqual(viewModel.isButtonDisabled, false)
        XCTAssertEqual(viewModel.a11yButtonHint, "Lets you book room \(room.name)")
        XCTAssertNil(viewModel.imageURL)
    }

    func testRoomWithNoSpotLeft() {
        let room = Room.mock(spotsCount: 0)
        let viewModel = RoomRowViewModel(room: room, onButtonTap: {})

        XCTAssertEqual(viewModel.id, room)
        XCTAssertEqual(viewModel.title, room.name)
        XCTAssertEqual(viewModel.subtitle, "Room is unavailable")
        XCTAssertEqual(viewModel.a11yImageLabel, "Room \(room.name)")
        XCTAssertEqual(viewModel.a11yImageHint, "Room is unavailable")
        XCTAssertEqual(viewModel.isButtonDisabled, true)
        XCTAssertEqual(viewModel.a11yButtonHint, "Disabled")
        XCTAssertNil(viewModel.imageURL)
    }
}
