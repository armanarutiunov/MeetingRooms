//
//  MeetingRoomsView.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import SwiftUI

public struct MeetingRoomsView: View {

    // MARK: - Properties

    @StateObject private var viewModel = MeetingRoomsViewModel()

    // MARK: - Life Cycle

    public init() {}

    // MARK: - Body

    public var body: some View {
        Text("Hello, World!")
    }
}

// MARK: - Previews
struct MeetingRoomsView_Previews: PreviewProvider {

    static var previews: some View {
        MeetingRoomsView()
    }
}
