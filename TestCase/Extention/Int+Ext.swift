//
//  Int+Ext.swift
//  TestCase
//
//  Created by Rafli on 14/06/23.
//

import Foundation
extension Int {
    func formattedString() -> String {
        return Formatter.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func toTime() -> String {
        let seconds: Int = self % 60
        let minutes: Int = (self / 60) % 60
        let hours: Int = self / 3600

        //MARK: set to ui
        if hours == 0 && minutes == 0 && seconds == 0 {
            return String(format: "00:00:00", hours, minutes, seconds)
        }else{
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
    
//    func toUnit() -> String{
//        if(UserDefaultsManager.shared.getUnit() == "KG"){
//            return self.formattedString()
//        } else{
//            return (self /  1.609).formatted()
//        }
//    }
    
}


