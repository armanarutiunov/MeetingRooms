//
//  RoomManagerTests.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

@testable import RoomManager
import Cloud
import Datastore
import Utilities
import XCTest

@MainActor
final class RoomManagerTests: XCTestCase {

    // MARK: - Life Cycle

    override func tearDown() {
        Datastore.deleteAll(of: [Room].self)

        super.tearDown()
    }

    // MARK: - Test

    func testFetchRoomsSuccess() async throws {
        let expectedResponse = RoomsResponse(rooms: [.mock()])
        let cloudManager = MockCloudManager(expectedResult: .success(expectedResponse))
        let manager = RoomManager(cloudManager: cloudManager)

        XCTAssertNil(manager.cachedRooms)

        let response = try await manager.fetchRooms()

        XCTAssertEqual(response, expectedResponse.rooms)
        XCTAssertEqual(manager.cachedRooms, expectedResponse.rooms)
    }

    func testFetchRoomsFailure() async throws {
        let expectedError = NSError.unknown
        let cloudManager = MockCloudManager(expectedResult: .failure(expectedError))
        let manager = RoomManager(cloudManager: cloudManager)

        do {
            let _ = try await manager.fetchRooms()
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }

    func testBookRoomSuccess() async throws {
        let expectedResponse = BookRoomResponse(isSuccess: true)
        let cloudManager = MockCloudManager(expectedResult: .success(expectedResponse))
        let manager = RoomManager(cloudManager: cloudManager)

        let response = try await manager.book(.mock())

        XCTAssertEqual(response, expectedResponse.isSuccess)
    }

    func testBookRoomFailure() async throws {
        let expectedError = NSError.unknown
        let cloudManager = MockCloudManager(expectedResult: .failure(expectedError))
        let manager = RoomManager(cloudManager: cloudManager)

        do {
            let _ = try await manager.book(.mock())
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}
