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

    func request<T: Decodable>(with endpoint: Endpoint) async throws -> T
}

public final class CloudManager: CloudManageable {

    // MARK: - Declarations

    private enum Constant {
        static let timeoutInterval = 10.0
    }

    // MARK: - Properties

    public static let shared = CloudManager()

    // MARK: - Life Cycle

    private init() {}

    // MARK: - Actions

    public func request<T: Decodable>(with endpoint: Endpoint) async throws -> T {
        let urlRequest = URLRequest(url: endpoint.url,
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: Constant.timeoutInterval)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try data.decoded()
    }
}
