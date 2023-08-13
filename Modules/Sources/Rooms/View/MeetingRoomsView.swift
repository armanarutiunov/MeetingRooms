//
//  MeetingRoomsView.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import SwiftUI

public struct MeetingRoomsView: View {

    // MARK: - Declarations

    private enum Constant {
        enum Header {
            static let title = "Rooms"
            static let spacing = 10.0
            static let subtitle = "Odio nisi, lectus dis nulla. Ultrices maecenas vitae rutrum dolor ultricies donec risus sodales. Tempus quis et."
            static let insets = EdgeInsets(top: 25, leading: 5, bottom: 25, trailing: 5)
        }

        enum Alert {
            static let buttonTitle = "OK"
        }
    }

    // MARK: - Properties

    @StateObject private var viewModel = MeetingRoomsViewModel()

    @Environment(\.colorScheme) private var colorScheme

    // MARK: - Life Cycle

    public init() {}

    // MARK: - Body

    public var body: some View {
        List {
            Section {
                sectionContent
            } header: {
                header
            }
            .listSectionSeparator(.hidden)
        }
        .listStyle(.grouped)
        .refreshable(action: viewModel.fetchRooms)
        .onAppear(perform: viewModel.onAppear)
        .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertPresented) {
            Button(Constant.Alert.buttonTitle) {}
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: Constant.Header.spacing) {
            Text(Constant.Header.title)
                .font(.helvetica(.headline).bold())
                .foregroundColor(viewModel.titleColor(with: colorScheme))
                .accessibilityAddTraits(.isHeader)

            Text(Constant.Header.subtitle)
                .font(.helvetica(.subheadline))
                .foregroundColor(.gray)
        }
        .textCase(.none)
        .padding(Constant.Header.insets)
    }

    private var sectionContent: some View {
        ForEach(viewModel.roomRowViewModels) { viewModel in
            RoomRowView(viewModel: viewModel)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
        }
    }
}

// MARK: - Previews
struct MeetingRoomsView_Previews: PreviewProvider {

    static var previews: some View {
        MeetingRoomsView()
    }
}
