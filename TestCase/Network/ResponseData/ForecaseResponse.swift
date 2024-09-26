//
//  ForecaseResponse.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import Foundation

struct ForecaseResponse: Codable {
    
    let list:[WeatherResponse]
    
    enum CodingKeys: String, CodingKey {
        case list = "list"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        list = try values.decodeIfPresent([WeatherResponse].self, forKey: .list) ?? [WeatherResponse]()

    }
    
}
