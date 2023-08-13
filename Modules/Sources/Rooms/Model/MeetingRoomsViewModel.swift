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

    // MARK: - Life Cycle

    init(roomManager: RoomManageable? = nil) {
        self.roomManager = roomManager ?? RoomManager.shared
    }
}
