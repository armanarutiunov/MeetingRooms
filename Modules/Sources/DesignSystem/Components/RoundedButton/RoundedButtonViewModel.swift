//
//  RoundedButtonViewModel.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import SwiftUI

struct RoundedButtonViewModel {

    // MARK: - Properties

    let title: String

    private let style: RoundedButton.Style

    let action: () -> Void

    var backgroundColor: Color {
        switch style {
        case .cherry:
            return .cherry
        }
    }

    var foregroundColor: Color {
        switch style {
        case .cherry:
            return .white
        }
    }

    var font: Font {
        switch style {
        case .cherry:
            return .helvetica(.buttonTitle).bold()
        }
    }

    // MARK: - Life Cycle

    init(title: String, style: RoundedButton.Style, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action = action
    }
}
