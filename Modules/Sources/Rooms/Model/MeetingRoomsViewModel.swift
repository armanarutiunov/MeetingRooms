//
//  MeetingRoomsViewModel.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Combine
import Cloud
import RoomManager
import SwiftUI

@MainActor
final class MeetingRoomsViewModel: ObservableObject {

    // MARK: - Declarations

    private enum AlertType {
        case roomBooked(Room)
        case roomUnavailable(Room)
        case error(NSError)
    }

    // MARK: - Properties

    let roomManager: RoomManageable

    @Published private(set) var roomRowViewModels = [RoomRowViewModel]()

    @Published private var alertType: AlertType? {
        didSet {
            isAlertPresented = alertType != nil
        }
    }

    @Published var isAlertPresented = false

    private var cancellables = Set<AnyCancellable>()

    var alertTitle: String {
        switch alertType {
        case .roomBooked(let room):
            return "Room \(room.name) is successfully booked"

        case .roomUnavailable(let room):
            return "Unfortunately, room \(room.name) is no longer available"

        case .error(let error):
            return error.localizedDescription

        case .none:
            return ""
        }
    }

    // MARK: - Life Cycle

    init(roomManager: RoomManageable? = nil) {
        self.roomManager = roomManager ?? RoomManager.shared
    }

    func onAppear() {
        Task { [weak self] in
            await self?.fetchRooms()
        }
    }

    // MARK: - Actions

    @Sendable func fetchRooms() async {
        do {
            let rooms = try await roomManager.fetchRooms()
            roomRowViewModels = roomRowViewModels(from: rooms)
        } catch {
            handleRoomsFetchError(error)
        }
    }

    private func handleRoomsFetchError(_ error: Error) {
        guard error.isConnectionFailure else {
            alertType = .error(error as NSError)
            return
        }

        monitorReconnection()

        if let cachedRooms = roomManager.cachedRooms,
           !cachedRooms.isEmpty {
            roomRowViewModels = roomRowViewModels(from: cachedRooms)
        } else {
            alertType = .error(error as NSError)
        }
    }

    func book(_ room: Room) async {
        do {
            let isSuccess = try await roomManager.book(room)
            alertType = isSuccess ? .roomBooked(room) : .roomUnavailable(room)
        } catch {
            if error.isConnectionFailure {
                monitorReconnection()
            }

            alertType = .error(error as NSError)
        }
    }

    private func monitorReconnection() {
        NetworkMonitor.shared.$isConnected
            .first(where: { $0 == true })
            .sink { [weak self] _ in
                Task {
                    await self?.fetchRooms()
                }
            }
            .store(in: &cancellables)
    }

    func titleColor(with colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .light:
            return .black

        case .dark:
            return .white

        @unknown default:
            return .black
        }
    }

    // MARK: - Helpers

    private func roomRowViewModels(from rooms: [Room]) -> [RoomRowViewModel] {
        rooms.map { room in
            RoomRowViewModel(room: room, onButtonTap: {
                Task { [weak self] in
                    await self?.book(room)
                }
            })
        }
    }
}
