//
//  MockRoomManager.swift
//  
//
//  Created by Arman Arutiunov on 14/08/2023.
//

import Foundation

public final class MockRoomManager: RoomManageable {

    // MARK: - Properties

    private let fetchedRooms: [Room]

    public let cachedRooms: [Room]?

    private let isBookingSuccessful: Bool

    private let error: Error?

    // MARK: - Life Cycle

    public init(fetchedRooms: [Room] = [], cachedRooms: [Room]? = nil, isBookingSuccessful: Bool = false, error: Error? = nil) {
        self.fetchedRooms = fetchedRooms
        self.cachedRooms = cachedRooms
        self.isBookingSuccessful = isBookingSuccessful
        self.error = error
    }

    // MARK: - Actions

    public func fetchRooms() async throws -> [Room] {
        if let error {
            throw error
        }

        return fetchedRooms
    }

    public func book(_ room: Room) async throws -> Bool {
        if let error {
            throw error
        }

        return isBookingSuccessful
    }
}
