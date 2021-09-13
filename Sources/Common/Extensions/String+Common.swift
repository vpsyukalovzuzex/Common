//
// String+Common.swift
//

import Foundation

public extension String {
    
    var localizable: String {
        return NSLocalizedString(self, comment: "")
    }
}
