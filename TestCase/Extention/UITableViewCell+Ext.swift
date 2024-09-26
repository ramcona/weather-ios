//
//  UITableViewCell+Ext.swift
//  TestCase
//
//  Created by Rafli on 12/06/23.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var className: String {
        return String(describing: self)
    }
}
