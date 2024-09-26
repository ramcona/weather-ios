//
//  RegionService.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import Foundation

class RegionService {
    
    private let requestManager = APIRequestManager()
     
    func province(completion: @escaping (Result<[Province], Error>) -> Void) {
        requestManager.get(path: "provinces.json", completion: completion, networkType: .region)
    }
    
    func city(provinceId:String, completion: @escaping (Result<[City], Error>) -> Void) {
        requestManager.get(path: "regencies/\(provinceId).json", completion: completion, networkType: .region)
    }
    
}
