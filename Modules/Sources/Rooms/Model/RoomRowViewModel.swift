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

    let room: Room

    let id: Room

    var imageURL: URL? {
        room.imageURL
    }

    // MARK: - Life Cycle

    init(room: Room) {
        self.room = room
        self.id = room
    }
}
