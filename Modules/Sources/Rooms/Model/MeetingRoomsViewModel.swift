//
//  MeetingRoomsViewModel.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import RoomManager
import SwiftUI

@MainActor
final class MeetingRoomsViewModel: ObservableObject {

    // MARK: - Declarations

    private enum AlertType {
        case error(NSError)
    }

    // MARK: - Properties

    let roomManager: RoomManageable

    @Published private(set) var roomRowViewModels = [RoomRowViewModel]()

    // MARK: - Life Cycle

    init(roomManager: RoomManageable? = nil) {
        self.roomManager = roomManager ?? RoomManager.shared
    }

    func onAppear() {
        Task {
            await fetchRooms()
        }
    }

    // MARK: - Actions

    @Sendable func fetchRooms() async {
        do {
            let rooms = try await roomManager.fetchRooms()
            roomRowViewModels = roomRowViewModels(from: rooms)
        } catch {
            // TODO: Handle error
        }
    }

    // MARK: - Helpers

    private func roomRowViewModels(from rooms: [Room]) -> [RoomRowViewModel] {
        rooms
            .map { room in
                RoomRowViewModel(room: room)
            }
    }
}
