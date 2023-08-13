//
//  RoundedButton.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import SwiftUI

struct RoundedButton: View {

    // MARK: - Declarations

    private enum Constant {
        static let insets = EdgeInsets(top: 8, leading: 25, bottom: 8, trailing: 25)
        static let cornerRadius = 4.0
    }

    // MARK: - Properties

    private let viewModel: RoundedButtonViewModel

    // MARK: - Life Cycle

    init(_ title: String, action: @escaping () -> Void) {
        self.viewModel = RoundedButtonViewModel(title: title, action: action)
    }

    // MARK: - Body

    var body: some View {
        Button(action: viewModel.action) {
            Text(viewModel.title)
                .padding(Constant.insets)
                .font(.helvetica(.buttonTitle))
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(Constant.cornerRadius)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(viewModel.title)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton("Book!", action: {})
    }
}
