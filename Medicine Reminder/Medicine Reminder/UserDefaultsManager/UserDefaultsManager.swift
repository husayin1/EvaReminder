//
//  UserDefaultsManager.swift
//  Medicine Reminder
//
//  Created by husayn on 26/08/2024.
//

import Foundation
class UserDefaultsManager {
    // MARK: - Singleton Instance
    
    static let shared = UserDefaultsManager()
    
    // MARK: - Initialization
    
    private init() {}
    
    var deviceToken: String? {
            get {
                return UserDefaults.standard.string(forKey: "deviceToken")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "deviceToken")
            }
        }
    
    var bearerToken: String? {
            get {
                return UserDefaults.standard.string(forKey: "bearerToken")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "bearerToken")
            }
        }
}
