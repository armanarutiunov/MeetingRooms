//
//  RoomRowView.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import DesignSystem
import NukeUI
import SwiftUI

struct RoomRowView: View {

    // MARK: - Declarations

    private enum Constant {
        static let padding = 25.0
        static let insets = EdgeInsets(top: 0, leading: padding, bottom: padding, trailing: padding)

        enum Card {
            static let placeholderImage = "room-placeholder"
            static let ratio: CGFloat = 3/2
            static let cornerRadius = 11.0
        }
    }

    // MARK: - Properties

    @ObservedObject var viewModel: RoomRowViewModel

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .bottom) {
            image
        }
        .aspectRatio(Constant.Card.ratio, contentMode: .fill)
        .cornerRadius(Constant.Card.cornerRadius)
        .padding(Constant.insets)
    }

    private var image: some View {
        LazyImage(url: viewModel.imageURL) { state in
            if state.isLoading {
                Color.gray
            } else {
                (state.image ?? Image(Constant.Card.placeholderImage))
                    .cropped(ratio: Constant.Card.ratio)
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
