//
//  Error.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Foundation

extension Error {

    private var NSURLErrorConnectionFailureCodes: [Int] {
        [NSURLErrorBackgroundSessionInUseByAnotherProcess,
         NSURLErrorCannotFindHost,
         NSURLErrorCannotConnectToHost,
         NSURLErrorNetworkConnectionLost,
         NSURLErrorNotConnectedToInternet,
         NSURLErrorSecureConnectionFailed]
    }

    public var isConnectionFailure: Bool {
        NSURLErrorConnectionFailureCodes.contains(_code)
    }

    public static var unknown: NSError {
        NSError(domain: "com.wetransfer.wetransfer-error", code: 1)
    }

    public static var connection: NSError {
        NSError(domain: "com.wetransfer.wetransfer-error", code: NSURLErrorNotConnectedToInternet, userInfo: [NSLocalizedDescriptionKey: "No Internet"])
    }
}
