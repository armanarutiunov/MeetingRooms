//
//  RoomRowView.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import SwiftUI

struct RoomRowView: View {

    // MARK: - Properties

    let viewModel: RoomRowViewModel

    // MARK: - Body

    var body: some View {
        Text("Hello, World!")
    }
}

// MARK: - Previews
struct RoomRowViewSRoomRowView_Previews: PreviewProvider {

    static var previews: some View {
        RoomRowView(viewModel: .init(room: .mock()))
    }
}
