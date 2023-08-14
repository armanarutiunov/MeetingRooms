//
//  MeetingRoomsViewModelTests.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import RoomManager
@testable import Rooms
import XCTest

@MainActor
final class RoomsViewModelTests: XCTestCase {

    // MARK: - Fetch Rooms

    func testRoomsFetchSuccess() async {
        let expectedRooms = [Room.mock()]
        let manager = MockRoomManager(fetchedRooms: expectedRooms)
        let viewModel = MeetingRoomsViewModel(roomManager: manager)

        await viewModel.fetchRooms()

        XCTAssertEqual(viewModel.roomRowViewModels.map { $0.id }, expectedRooms)
        XCTAssertFalse(viewModel.isAlertPresented)
        XCTAssertEqual(viewModel.alertTitle, "")
    }

    func testRoomsFetchUnknownErrorWithEmptyCache() async {
        let expectedError = NSError.unknown
        let manager = MockRoomManager(error: expectedError)
        let viewModel = MeetingRoomsViewModel(roomManager: manager)

        await viewModel.fetchRooms()

        XCTAssertEqual(viewModel.roomRowViewModels, [])
        XCTAssertTrue(viewModel.isAlertPresented)
        XCTAssertEqual(viewModel.alertTitle, expectedError.localizedDescription)
    }

    func testRoomsFetchUnknownFailureWithNonEmptyCache() async {
        let cachedRooms = [Room.mock()]
        let expectedError = NSError.unknown
        let manager = MockRoomManager(cachedRooms: cachedRooms, error: expectedError)
        let viewModel = MeetingRoomsViewModel(roomManager: manager)

        await viewModel.fetchRooms()

        XCTAssertEqual(viewModel.roomRowViewModels, [])
        XCTAssertTrue(viewModel.isAlertPresented)
        XCTAssertEqual(viewModel.alertTitle, expectedError.localizedDescription)
    }

    func testRoomsFetchConnectionFailureWithEmptyCache() async {
        let expectedError = NSError.connection
        let manager = MockRoomManager(error: expectedError)
        let viewModel = MeetingRoomsViewModel(roomManager: manager)

        await viewModel.fetchRooms()

        XCTAssertEqual(viewModel.roomRowViewModels, [])
        XCTAssertTrue(viewModel.isAlertPresented)
        XCTAssertEqual(viewModel.alertTitle, expectedError.localizedDescription)
    }

    func testRoomsFetchConnectionFailureWithNonEmptyCache() async {
        let cachedRooms = [Room.mock()]
        let expectedError = NSError.connection
        let manager = MockRoomManager(cachedRooms: cachedRooms, error: expectedError)
        let viewModel = MeetingRoomsViewModel(roomManager: manager)

        await viewModel.fetchRooms()

        XCTAssertEqual(viewModel.roomRowViewModels.map { $0.id }, cachedRooms)
        XCTAssertFalse(viewModel.isAlertPresented)
        XCTAssertEqual(viewModel.alertTitle, "")
    }

    // MARK: - Book Room

    func testBookRoomSuccess_isBookingSuccessful() async {
        let expectedRoom = Room.mock()
        let bookingResult = true
        let manager = MockRoomManager(fetchedRooms: [expectedRoom], isBookingSuccessful: bookingResult)
        let viewModel = MeetingRoomsViewModel(roomManager: manager)

        await viewModel.book(expectedRoom)

        XCTAssertTrue(viewModel.isAlertPresented)

        let expectedAlertTitle = "Room \(expectedRoom.name) is successfully booked"
        XCTAssertEqual(viewModel.alertTitle, expectedAlertTitle)
    }

    func testBookRoomSuccess_isBookingUnsuccessful() async {
        let expectedRoom = Room.mock()
        let bookingResult = false
        let manager = MockRoomManager(fetchedRooms: [expectedRoom], isBookingSuccessful: bookingResult)
        let viewModel = MeetingRoomsViewModel(roomManager: manager)

        await viewModel.book(expectedRoom)

        XCTAssertTrue(viewModel.isAlertPresented)

        let expectedAlertTitle = "Unfortunately, room \(expectedRoom.name) is no longer available"
        XCTAssertEqual(viewModel.alertTitle, expectedAlertTitle)
    }

    func testBookRoomFailure() async {
        let expectedRoom = Room.mock()
        let bookingResult = true
        let expectedError = NSError.connection
        let manager = MockRoomManager(fetchedRooms: [expectedRoom], isBookingSuccessful: bookingResult, error: expectedError)
        let viewModel = MeetingRoomsViewModel(roomManager: manager)

        await viewModel.book(expectedRoom)

        XCTAssertTrue(viewModel.isAlertPresented)
        XCTAssertEqual(viewModel.alertTitle, expectedError.localizedDescription)
    }
}
