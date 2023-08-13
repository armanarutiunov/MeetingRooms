//
//  RoomRowViewModel.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import RoomManager

struct RoomRowViewModel: Identifiable {

    // MARK: - Properties

    private let room: Room

    var id: Int {
        room.id
    }

    // MARK: - Life Cycle

    init(room: Room) {
        self.room = room
    }
}
