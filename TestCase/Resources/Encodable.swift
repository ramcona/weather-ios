//
//  Encodable.swift
//  TestCase
//
//  Created by Rafli on 06/06/23.
//  Copyright © 2023 CAN Craetive. All rights reserved.
//

import Foundation

extension Encodable {
    
//    let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
    
    func toData(using encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}
