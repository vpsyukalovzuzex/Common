//
// Keyboardable.swift
//

#if os(iOS)

import UIKit

public protocol Keyboardable {
    
    var isKeyboardShow: Bool { get set }
    
    func keyboardWillShow(_ isShow: Bool, beginFrame: CGRect, endFrame: CGRect, duration: CGFloat)
    func keyboardDidShow(_ isShow: Bool, beginFrame: CGRect, endFrame: CGRect, duration: CGFloat)
}

public extension Keyboardable {
    
    func keyboardDidShow(_ isShow: Bool, beginFrame: CGRect, endFrame: CGRect, duration: CGFloat) {
        // Optional.
    }
    
    func keyboardWillShow(_ isShow: Bool, beginFrame: CGRect, endFrame: CGRect, duration: CGFloat) {
        // Optional.
    }
}

#endif
