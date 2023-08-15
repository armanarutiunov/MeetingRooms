//
//  NetworkMonitor.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import Combine
import Foundation
import Network

public final class NetworkMonitor: ObservableObject {

    // MARK: - Properties

    public static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()

    private let queue = DispatchQueue(label: "NetworkManager")

    @Published public var isConnected: Bool = false

    @Published public var activeInterfaces: [NWInterface.InterfaceType] = []

    @Published public var unsatisfiedReason: NWPath.UnsatisfiedReason?

    // MARK: - Life Cycle

    private init() {}

    // MARK: - Actions

    public func start() {
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                switch path.status {
                case .requiresConnection, .unsatisfied:
                    self?.isConnected = false
                    self?.unsatisfiedReason = path.unsatisfiedReason

                case .satisfied:
                    self?.isConnected = true

                @unknown default:
                    break
                }

                self?.activeInterfaces = NWInterface.InterfaceType.allCases.filter {
                    path.usesInterfaceType($0)
                }
            }
        }
    }

    public func stop() {
        monitor.cancel()
    }
}

// MARK: - InterfaceType: CaseIterable
extension NWInterface.InterfaceType: CaseIterable {

    public static var allCases: [NWInterface.InterfaceType] {
        [.cellular,
         .loopback,
         .other,
         .wifi,
         .wiredEthernet]
    }
}
