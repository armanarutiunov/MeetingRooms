//
//  Bundle.swift
//  
//
//  Created by Arman Arutiunov on 13/08/2023.
//

import class Foundation.Bundle

private class BundleFinder {}

extension Bundle {

    public static var designSystem: Bundle = {
        guard let bundleURL = Bundle(for: BundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Modules_DesignSystem.bundle"),
              let bundle = Bundle(url: bundleURL) else {
            return Bundle.module
        }

        return bundle
    }()
}
