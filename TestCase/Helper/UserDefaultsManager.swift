//
//  UserDefaultsManager.swift
//  TestCase
//
//  Created by Rafli on 31/05/23.
//  Copyright © 2023 CAN Craetive. All rights reserved.
//

import Foundation
import UIKit

public struct Keys {
    static let userData = "UserData"
    static let loginStatus = "LoginStatus"
    static let token = "Token"
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    
    private let imagesDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Images")
        
        init() {
            // Create the directory if it doesn't exist
            if !FileManager.default.fileExists(atPath: imagesDirectory.path) {
                do {
                    try FileManager.default.createDirectory(at: imagesDirectory, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("Failed to create images directory: \(error)")
                }
            }
        }
    
    func clear() {
        let dictionary = userDefaults.dictionaryRepresentation()
          dictionary.keys.forEach { key in
              userDefaults.removeObject(forKey: key)
          }
    }
    
    func removeSavedData(_ key:String) {
        userDefaults.removeObject(forKey: key)
    }
    
    func setUser(_ userData: User) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(userData)
            userDefaults.set(encodedData, forKey: Keys.userData)
        } catch {
            print("Failed to encode user data: \(error)")
        }
    }
    
    func getUser() -> User? {
        if let encodedData = userDefaults.data(forKey: Keys.userData) {
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(User.self, from: encodedData)
                return userData
            } catch {
                print("Failed to decode user data: \(error)")
            }
        }
        return nil
    }

    func setLoginStatus(_ status: Bool) {
        userDefaults.set(status, forKey: Keys.loginStatus)
    }
    
    func getLoginStatus() -> Bool {
        return userDefaults.bool(forKey: Keys.loginStatus)
    }
    
    func setToken(_ status: String) {
        userDefaults.set(status, forKey: Keys.token)
    }
    
    func getToken() -> String {
        return userDefaults.string(forKey: Keys.token) ?? ""
    }
    
}

