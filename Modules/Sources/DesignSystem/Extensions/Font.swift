//
//  Font.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import SwiftUI

extension Font {

    public enum FontType: CGFloat {
        case headline = 36
        case subheadline = 18
        case description = 16
        case buttonTitle = 12

        var size: CGFloat {
            rawValue
        }
    }

    public static func helvetica(_ type: FontType) -> Font {
        .custom("Helvetica", size: type.size)
    }
}
