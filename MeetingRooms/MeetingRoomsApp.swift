//
//  MeetingRoomsApp.swift
//  MeetingRooms
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Cloud
import Rooms
import SwiftUI

@main
struct MeetingRoomsApp: App {

    // MARK: - Properties

    private let networkMonitor = NetworkMonitor.shared

    // MARK: - Life Cycle

    init() {
        networkMonitor.start()
    }

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            MeetingRoomsView()
        }
    }
}
