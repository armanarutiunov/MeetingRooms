//
//  BookRoomResponse.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

struct BookRoomResponse: Decodable {

    // MARK: - Declarations

    enum CodingKeys: String, CodingKey {
        case isSuccess = "success"
    }

    // MARK: - Properties

    let isSuccess: Bool
}
