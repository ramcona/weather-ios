//
//  String+Ext.swift
//  TestCase
//
//  Created by Rafli on 31/05/23.
//

import Foundation
import UIKit

extension String {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    func isNotEmptyString() -> Bool {
        return !self.isEmpty
    }
    
    func formattedNumber() -> String? {
        return Formatter.numberFormatter.number(from: self)?.stringValue
    }
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: date)
        }
        
        return self
    }
    
    func formatDateCreatedAt() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "HH:mm, dd MMM yyyy"
            return dateFormatter.string(from: date)
        }
        
        return self
    }
    
    func formatDate(from:String, to:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = from
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = to
            return dateFormatter.string(from: date)
        }
        
        return self
    }
    
    func htmlEncoded() -> String? {
        let data = self.data(using: .utf8)
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data ?? Data(), options: options, documentAttributes: nil) else {
            return nil
        }
        
        return attributedString.string
    }
    
    func htmlAttributeEncoded() -> String {
        let encodedString = self.replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&#39;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "&", with: "&amp;")
        
        return encodedString
    }
    
    
}




