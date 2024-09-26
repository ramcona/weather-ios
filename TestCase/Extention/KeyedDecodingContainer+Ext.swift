//
//  KeyedDecodingContainer+Ext.swift
//  TestCase
//
//  Created by Rafli on 10/08/23.
//

import Foundation

extension KeyedDecodingContainer {
    
    func decodeStringOrNumber(forKey key: Key) throws -> String {
        if let intValue = try? decode(Int.self, forKey: key) {
            return String(intValue)
        } else if let doubleValue = try? decode(Double.self, forKey: key) {
            return String(doubleValue)
        } else if let stringValue = try? decode(String.self, forKey: key) {
            return stringValue
        } else if let nullValue = try? decodeNil(forKey: key), nullValue {
            return ""
        }
        
        throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Unexpected value found.")
    }
}
