//
//  ColorConstants.swift
//  TestCase
//
//  Created by Rafli on 06/06/23.
//  Copyright © 2023 CAN Craetive. All rights reserved.
//

import Foundation
import UIKit

struct ColorConstants {
    static let primaryColor = UIColor(named: "PrimaryColor")!
    static let backgroudSoftPrimary = UIColor(named: "BackgroudSoftPrimaryColor")!
    static let primaryLightColor = UIColor(named: "PrimaryLightColor")!
    static let redColor = UIColor(named: "RedColor")!
    static let successColor = UIColor(named: "SuccessColor")!
    static let textColor = UIColor(named: "TextColor")!
    static let backgroundColor = UIColor(named: "BackgroundColor")!
    static let grayColor = UIColor(named: "GrayColor")!
    static let greyLightColor = UIColor(named: "GreyLightColor")!
    static let greyOutline = UIColor(named: "GreyOutline")!
    static let accentColor = UIColor(named: "AccentColor")!
    static let orangeColor = UIColor(named: "OrangeColor")!
    static let warningColor = UIColor(named: "WarningColor")!

    
    static var gradientBackground: [CGColor] {
        if #available(iOS 13.0, *) {
            return [UIColor.systemGray4.cgColor, UIColor.systemGray5.cgColor, UIColor.systemGray5.cgColor]
        } else {
            return [UIColor(hexValue: 0xDADADE).cgColor, UIColor(hexValue: 0xEAEAEE).cgColor, UIColor(hexValue: 0xDADADE).cgColor]
        }
    }
    static var separator: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray3
        } else {
            return UIColor(hexValue: 0xD1D1D6)
        }
    }

}
