//
//  Formatter+Ext.swift
//  TestCase
//
//  Created by Rafli on 14/06/23.
//

import Foundation

extension Formatter {
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
}
