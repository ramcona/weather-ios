//
//  UIColor+Ext.swift
//  TestCase
//
//  Created by Rafli on 06/06/23.
//

import Foundation
import UIKit

internal extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }

    convenience init(hexValue: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hexValue >> 16) & 0xFF,
            green: (hexValue >> 8) & 0xFF,
            blue: hexValue & 0xFF,
            a: a
        )
    }

    static func adaptive(dark: UIColor, light: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
        } else {
            return light
        }
    }
}

