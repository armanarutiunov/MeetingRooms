//
//  Image.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import SwiftUI

extension Image {

    public init(_ named: String) {
        self.init(named, bundle: .designSystem)
    }
}
