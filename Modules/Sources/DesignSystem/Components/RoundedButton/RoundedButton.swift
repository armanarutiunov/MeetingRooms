//
//  RoundedButton.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import SwiftUI

public struct RoundedButton: View {

    // MARK: - Declarations

    private enum Constant {
        static let insets = EdgeInsets(top: 8, leading: 25, bottom: 8, trailing: 25)
        static let cornerRadius = 4.0
    }

    public enum Style {
        case cherry
    }

    // MARK: - Properties

    private let viewModel: RoundedButtonViewModel

    // MARK: - Life Cycle

    public init(_ title: String, style: Style, action: @escaping () -> Void) {
        self.viewModel = RoundedButtonViewModel(title: title, style: style, action: action)
    }

    // MARK: - Body

    public var body: some View {
        Button(action: viewModel.action) {
            Text(viewModel.title)
                .padding(Constant.insets)
                .font(viewModel.font)
                .background(viewModel.backgroundColor)
                .foregroundColor(viewModel.foregroundColor)
                .cornerRadius(Constant.cornerRadius)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(viewModel.title)
    }
}

// MARK: - Previews
struct RoundedButton_Previews: PreviewProvider {

    static var previews: some View {
        RoundedButton("Book!", style: .cherry, action: {})
    }
}
