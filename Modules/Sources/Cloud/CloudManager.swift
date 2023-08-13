//
//  CloudManager.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Foundation
import Utilities

@MainActor
public protocol CloudManageable {

    func request<T: Decodable>(with url: URL) async throws -> T
}

public final class CloudManager: CloudManageable {

    // MARK: - Properties

    public static let shared = CloudManager()

    // MARK: - Life Cycle

    private init() {}

    // MARK: - Actions

    public func request<T: Decodable>(with url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try data.decoded()
    }
}
