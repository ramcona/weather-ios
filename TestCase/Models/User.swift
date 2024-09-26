//
//  User.swift
//  TestCase
//
//  Created by Rafli on 31/05/23.
//  Copyright © 2023 CAN Craetive. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String
    let province: Province?
    let city: City?
}
