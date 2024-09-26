//
//  WeatherService.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import Foundation

class WeatherService {
    
    private let requestManager = APIRequestManager()
     
    func current(cityName:String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        requestManager.get(path: "weather?q=\(cityName)", completion: completion, networkType: .weather)
    }
    
    func forecase(cityName:String, completion: @escaping (Result<ForecaseResponse, Error>) -> Void) {
        requestManager.get(path: "forecast?q=\(cityName)", completion: completion, networkType: .weather)
    }
    
}
