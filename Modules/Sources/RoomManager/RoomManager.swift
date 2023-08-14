//
//  RoomManager.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Cloud
import Datastore

@MainActor
public protocol RoomManageable {

    var cachedRooms: [Room]? { get }

    func fetchRooms() async throws -> [Room]
    func book(_ room: Room) async throws -> Bool
}

public final class RoomManager: RoomManageable {

    // MARK: - Declarations

    private enum DatastoreKey {
        static let cachedRooms = "RoomManager.cachedRooms"
    }

    // MARK: - Properties

    public static let shared = RoomManager()

    private let cloudManager: CloudManageable

    public var cachedRooms: [Room]? {
        Datastore.load(key: DatastoreKey.cachedRooms)
    }

    // MARK: - Life Cycle

    public init(cloudManager: CloudManageable? = nil) {
        self.cloudManager = cloudManager ?? CloudManager.shared
    }

    // MARK: - Actions

    public func fetchRooms() async throws -> [Room] {
        let response: RoomsResponse = try await cloudManager.request(with: WeTransferEndpoint.rooms)
        Datastore.save(response.rooms, key: DatastoreKey.cachedRooms)
        return response.rooms
    }

    public func book(_ room: Room) async throws -> Bool {
        let response: BookRoomResponse = try await cloudManager.request(with: WeTransferEndpoint.bookRoom)
        return response.isSuccess
    }
}
