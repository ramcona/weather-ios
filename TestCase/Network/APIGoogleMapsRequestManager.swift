//
//  APIGoogleMapsRequestManager.swift
//  Jaktivity
//
//  Created by Rafli on 27/07/23.
//  Copyright © 2023 CAN Craetive. All rights reserved.
//

import Foundation

import Alamofire

class APIGoogleMapsRequestManager {
    
    private let baseURL = APIConstants.baseURLGoogleMaps
    private let apiKey = APIConstants.apiKey
    
    private func performRequest(path: String, method: HTTPMethod, parameters: [String: Any], body: Data?, completion: @escaping (Result<DirectionResponse, Error>) -> Void) {
        let url = baseURL + path
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method.rawValue
        
        if let requestBody = body {
            urlRequest.httpBody = requestBody
        }
        
        var networkLog = ""
        
        networkLog += "\(url) \n"
        networkLog += "\(parameters) \n"
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString).responseDecodable(of: DirectionResponse.self) { response in
            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                networkLog += "\nResponse: \(responseString) \n"
                print(networkLog)
            }
            
            switch response.result {
            case .success(let apiResponse):
                completion(.success(apiResponse))
            case .failure(let error):
                networkLog += "\nError: \(error.localizedDescription) \n"
                print(networkLog)
                debugPrint(error)
                completion(.failure(error))
            }
        }
    }
    
    func get(path: String, parameters:[String: Any], completion: @escaping (Result<DirectionResponse, Error>) -> Void) {
        performRequest(path: path, method: .get, parameters: parameters, body: nil, completion: completion)
    }
    
}
