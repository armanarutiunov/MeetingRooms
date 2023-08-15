//
//  MockCloudManager.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Foundation

public final class MockCloudManager: CloudManageable {

    // MARK: - Properties

    private let expectedResult: Result<Decodable, Error>

    private let requestDuration: TimeInterval

    // MARK: - Life Cycle

    public init(expectedResult: Result<Decodable, Error>, requestDuration: TimeInterval = 0.2) {
        self.expectedResult = expectedResult
        self.requestDuration = requestDuration
    }

    // MARK: - Actions

    public func request<T: Decodable>(with endpoint: Endpoint) async throws -> T {
        try await Task.sleep(for: .seconds(requestDuration))

        switch expectedResult {
        case .success(let object):
            return object as! T

        case .failure(let error):
            throw error
        }
    }
}
