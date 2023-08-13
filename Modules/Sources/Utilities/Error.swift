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
}
