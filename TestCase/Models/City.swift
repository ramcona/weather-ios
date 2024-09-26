//
//  City.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import Foundation

struct City : Codable {
    let id: String
    let province_id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case province_id = "province_id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        province_id = try values.decodeIfPresent(String.self, forKey: .province_id) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
    
}
