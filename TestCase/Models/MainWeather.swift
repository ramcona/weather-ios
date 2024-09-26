//
//  MainWeather.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import Foundation

struct MainWeather : Codable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Int
    let humidity: Int
    let sea_level: Int
    let grnd_level: Int
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feels_like = "feels_like"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        temp = try values.decodeIfPresent(Float.self, forKey: .temp) ?? 0
        feels_like = try values.decodeIfPresent(Float.self, forKey: .feels_like) ?? 0
        temp_min = try values.decodeIfPresent(Float.self, forKey: .temp_min) ?? 0
        temp_max = try values.decodeIfPresent(Float.self, forKey: .temp_max) ?? 0
        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure) ?? 0
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity) ?? 0
        sea_level = try values.decodeIfPresent(Int.self, forKey: .sea_level) ?? 0
        grnd_level = try values.decodeIfPresent(Int.self, forKey: .grnd_level) ?? 0
    }
    
}
