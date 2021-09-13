//
// String+Common.swift
//

import Foundation

public extension String {
    
    var localizable: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges = [Range<Index>]()
        while ranges.last.map({ $0.upperBound < endIndex }) ?? true, let range = range(of: substring, options: options, range: (ranges.last?.upperBound ?? startIndex)..<endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
    }
}
