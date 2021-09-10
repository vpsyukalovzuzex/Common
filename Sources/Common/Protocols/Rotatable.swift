//
// Rotatable.swift
//

#if os(iOS)

import UIKit

public protocol Rotatable {
    
    func deviceOrientationDidChange(_ orientation: UIDeviceOrientation)
}

public extension Rotatable {
    
    func deviceOrientationDidChange(_ orientation: UIDeviceOrientation) {
        // Optional.
    }
}

#endif
