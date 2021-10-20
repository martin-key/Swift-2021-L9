//
//  UserDefaultsData.swift
//  SoftUni-L8
//
//  Created by Martin Kuvandzhiev on 13.10.21.
//

import Foundation

class UserDefaultsData {
    static var email: String? {
        get {
            return UserDefaults.standard.string(forKey: .email)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: .email)
        }
    }
    
    static var username: String? {
        get {
            return UserDefaults.standard.string(forKey: .username)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: .username)
        }
    }
    
    static var numberOfAppOpens: Int {
        get {
            return UserDefaults.standard.integer(forKey: .numberOfAppOpens)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: .numberOfAppOpens)
            UserDefaults.standard.synchronize()
        }
    }
}


fileprivate extension String {
    static let email = "ud_user-email"
    static let username = "ud_user-username"
    static let accessToken = "ud_access-token"
    static let numberOfAppOpens = "ud_number-of-app-opens"
}
