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

        enum Image {
            static let placeholderImage = "room-placeholder"
            static let ratio: CGFloat = 3/2
            static let cornerRadius = 11.0
        }

        enum GradientStops {
            static let first = Gradient.Stop(color: .clear, location: 0.3)
            static let last = Gradient.Stop(color: .black.opacity(0.8), location: 1)
        }

        enum Content {
            static let spacing = 5.0
            static let padding = 15.0
        }

        enum Button {
            static let title = "Book!"
        }
    }

    // MARK: - Properties

    @ObservedObject var viewModel: RoomRowViewModel

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .bottom) {
            image
            gradient

            HStack(alignment: .bottom) {
                description
                Spacer()
                button
            }
            .padding(Constant.Content.padding)
        }
        .aspectRatio(Constant.Image.ratio, contentMode: .fill)
        .cornerRadius(Constant.Image.cornerRadius)
        .padding(Constant.insets)
    }

    private var image: some View {
        LazyImage(url: viewModel.imageURL) { state in
            if state.isLoading {
                Color.gray
            } else {
                (state.image ?? Image(Constant.Image.placeholderImage))
                    .cropped(ratio: Constant.Image.ratio)
            }
        }
    }

    private var gradient: some View {
        LinearGradient(stops: [Constant.GradientStops.first, Constant.GradientStops.last],
                       startPoint: .top,
                       endPoint: .bottom)
    }

    private var description: some View {
        VStack(alignment: .leading, spacing: Constant.Content.spacing) {
            Text(viewModel.title)
                .font(.helvetica(.description).bold())
                .foregroundColor(.white)

            if let subtitle = viewModel.subtitle {
                Text(subtitle)
                    .font(.helvetica(.description))
                    .foregroundColor(.gray)
            }
        }
    }

    private var button: some View {
        RoundedButton(Constant.Button.title, style: .cherry, action: viewModel.onButtonTap)
            .disabled(viewModel.isButtonDisabled)
    }
}

// MARK: - Previews
struct RoomRowViewSRoomRowView_Previews: PreviewProvider {

    static var previews: some View {
        List {
            ForEach(0..<3) { _ in
                RoomRowView(viewModel: .init(room: .mock(), onButtonTap: {}))
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.grouped)
    }
}
