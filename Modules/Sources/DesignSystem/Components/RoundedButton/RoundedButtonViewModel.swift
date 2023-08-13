//
//  RoundedButtonViewModel.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Foundation

struct RoundedButtonViewModel {

    // MARK: - Properties
    
    let title: String

    let action: () -> Void

    // MARK: - Life Cycle

    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}
