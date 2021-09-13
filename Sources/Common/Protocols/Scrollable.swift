//
// Scrollable.swift
//

import Foundation

#if os(iOS)

public protocol Scrollable {
    
    func scrollUp(animated: Bool)
}

public extension Scrollable {
    
    func scrollUp(animated: Bool) {
        // Optional.
    }
}

#endif
