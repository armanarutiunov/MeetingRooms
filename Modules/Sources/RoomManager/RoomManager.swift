//
//  RoomManager.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Cloud

@MainActor
public protocol RoomManageable {

    func fetchRooms() async throws -> [Room]
    func book(_ room: Room) async throws -> Bool
}

public final class RoomManager: RoomManageable {

    // MARK: - Properties

    public static let shared = RoomManager()

    private let cloudManager: CloudManageable

    // MARK: - Life Cycle

    public init(cloudManager: CloudManageable? = nil) {
        self.cloudManager = cloudManager ?? CloudManager.shared
    }

    // MARK: - Actions

    public func fetchRooms() async throws -> [Room] {
        let response: RoomsResponse = try await cloudManager.request(with: WeTransferEndpoint.rooms)
        // TODO: Save cache every time rooms are fetched
        return response.rooms
    }

    public func book(_ room: Room) async throws -> Bool {
        let response: BookRoomResponse = try await cloudManager.request(with: WeTransferEndpoint.bookRoom)
        return response.isSuccess
    }
}
