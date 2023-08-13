//
//  RoomRowViewModel.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Foundation
import RoomManager

@MainActor
final class RoomRowViewModel: ObservableObject, Identifiable {

    // MARK: - Properties

    private let room: Room

    let onButtonTap: () -> Void

    let id: Room

    var title: String {
        room.name
    }

    var subtitle: String? {
        switch room.spotsCount {
        case 1:
            return "1 spot remaining"

        case 2...:
            return "\(room.spotsCount) spots remaining"

        default:
            return "Room is unavailable"
        }
    }

    var imageURL: URL? {
        room.imageURL
    }

    // MARK: - Life Cycle

    init(room: Room, onButtonTap: @escaping () -> Void) {
        self.room = room
        self.id = room
        self.onButtonTap = onButtonTap
    }
}
