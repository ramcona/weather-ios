//
//  APIRequestManager.swift
//  TestCase
//
//  Created by Rafli on 22/05/23.
//

import Foundation
import Alamofire

class APIRequestManager {
    
    private let weatherBaseUrl = APIConstants.weatherBaseUrl + "data/2.5/"
    private let regionBaseUrl = APIConstants.regionBaseUrl + "api/"
    private let weatherAPIKey = APIConstants.weatherAPIKey
    
    
    private func performRequest<T: Codable>(path: String, method: HTTPMethod, parameters: Parameters?, body: Data?, completion: @escaping (Result<T, Error>) -> Void, networkType: NetworkType = .weather) {
        
        var url = ""
        
        
        if networkType == .weather {
         url = weatherBaseUrl + path + "&appid=\(weatherAPIKey)"
        }else {
            url = regionBaseUrl + path
        }
        
        var headers: HTTPHeaders = [
                                    "Accept": "application/json",
                                    "Content-Type": "application/json"]
                
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        
        if let requestBody = body {
            urlRequest.httpBody = requestBody
        }
        
        
        var networkLog = ""
        
        // Log request data
        if let url = urlRequest.url?.absoluteString {
            networkLog += "URL: \(url) \n"
        }
        
        if let method = urlRequest.httpMethod {
            networkLog += "Method: \(method) \n"
        }
        
        if let headers = urlRequest.allHTTPHeaderFields {
            networkLog += "Headers: \(headers) \n"
        }
        
        if let bodyData = urlRequest.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
            networkLog += "Body: \(bodyString) \n"
        }
        
        AF.request(urlRequest).responseDecodable(of: T.self) { response in
            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                networkLog += "\nResponse: \(responseString) \n"
                print(networkLog)
            }
            
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case 401:
                    // Handle Unauthorized
                    let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Unauthorized - Please log in again."])
                    completion(.failure(error))
                    
                case 500...599:
                    // Handle Server Errors
                    let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error - Please try again later."])
                    completion(.failure(error))
                    
                default:
                    // Handle other status codes
                    switch response.result {
                    case .success(let apiResponse):
                        completion(.success(apiResponse))
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                        networkLog += "\nError: \(error.localizedDescription) \n"
                        let errorM = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server error - Please try again later."])
                        completion(.failure(errorM))
                    }
                }
            } else {
                // Handle case where there's no status code
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse))
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    networkLog += "\nError: \(error.localizedDescription) \n"
                    let errorN = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server error - Please try again later."])
                    completion(.failure(errorN))
                }
            }
        }
    }
    
    func get<T: Codable>(path: String, completion: @escaping (Result<T, Error>) -> Void, networkType: NetworkType) {
        performRequest(path: path, method: .get, parameters: nil, body: nil, completion: completion, networkType: networkType)
    }
    
    func post<T: Codable>(path: String, parameters: Parameters?, body: Data?, completion: @escaping (Result<T, Error>) -> Void, networkType: NetworkType) {
        performRequest(path: path, method: .post, parameters: parameters, body: body, completion: completion, networkType: networkType)
    }
    
    func put<T: Codable>(path: String, parameters: Parameters?, body: Data?, completion: @escaping (Result<T, Error>) -> Void, networkType: NetworkType) {
        performRequest(path: path, method: .put, parameters: parameters, body: body, completion: completion, networkType: networkType)
    }
    
    func delete<T: Codable>(path: String, completion: @escaping (Result<T, Error>) -> Void, networkType: NetworkType) {
        performRequest(path: path, method: .delete, parameters: nil, body: nil, completion: completion, networkType: networkType)
    }
    
    
}
