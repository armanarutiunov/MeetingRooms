//
//  Data.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Foundation

extension Data {

    public func decoded<T: Decodable>() throws -> T {
        try JSONDecoder().decode(T.self, from: self)
    }
}
