//
//  RoomRowView.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import NukeUI
import SwiftUI

struct RoomRowView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: RoomRowViewModel

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .bottom) {
            image
        }
    }

    private var image: some View {
        LazyImage(url: viewModel.imageURL) { state in
            if state.isLoading {
                Color.gray
            } else {
                state.image
            }
        }
    }
}

// MARK: - Previews
struct RoomRowViewSRoomRowView_Previews: PreviewProvider {

    static var previews: some View {
        List {
            ForEach(0..<3) { _ in
                RoomRowView(viewModel: .init(room: .mock()))
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.grouped)
    }
}
