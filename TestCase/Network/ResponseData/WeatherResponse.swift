//
//  WeatherResponse.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import Foundation

struct WeatherResponse: Codable {
    
    let cod: Int
    let message: String
    let weather: [Weather]
    let main: MainWeather?
    let dt_txt:String
    
    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case weather = "weather"
        case main = "main"
        case dt_txt = "dt_txt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        cod = try values.decodeIfPresent(Int.self, forKey: .cod) ?? 0
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather) ?? [Weather]()
        main = try values.decodeIfPresent(MainWeather.self, forKey: .main)
        
        dt_txt = try values.decodeIfPresent(String.self, forKey: .dt_txt) ?? ""

    }
    
}
