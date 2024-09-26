//
//  Double+Ext.swift
//  TestCase
//
//  Created by Rafli on 17/07/23.
//

import Foundation

extension Double {
    
    func formattedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
    func kelvinToCelsiusString() -> String {
        let celsius = self - 273.15
        return celsius.formattedString()
    }
    
    
}

