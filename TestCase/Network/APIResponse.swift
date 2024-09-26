//
//  APIResponse.swift
//  TestCase
//
//  Created by Rafli on 22/05/23.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    var status:Bool = false
    var status_data:Bool = false
    var msg: String? = ""
    let data: T?
}
