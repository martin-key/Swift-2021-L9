//
//  User.swift
//  SoftUni-L8
//
//  Created by Martin Kuvandzhiev on 20.10.21.
//

import Foundation
import RealmSwift
import Realm

class User: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var birthDate: String = ""
    @Persisted var gender: String = ""
    @Persisted var height: Double = 0 // meters
    @Persisted var weight: Double = 0 // kilograms
    @Persisted var createdAt: String = ""
    @Persisted var updatedAt: String = Date().dateInISO8601
    
    static override func primaryKey() -> String? {
        return "id"
    }
}

extension User {
    enum Gender: String {
        case male
        case female
        case unknown
    }
}

extension User {
    var eGender: Gender {
        get {
            return User.Gender(rawValue: self.gender) ?? .unknown
        }
        set {
            self.realm?.beginWrite()
            self.gender = newValue.rawValue
            try? self.realm?.commitWrite()
        }
    }
    
    var eBirthDate: Date? {
        get {
            let dateFormatter = ISO8601DateFormatter()
            return dateFormatter.date(from: self.birthDate)
        }
        set {
            self.realm?.beginWrite()
            self.birthDate = newValue?.dateInISO8601 ?? ""
            try? self.realm?.commitWrite()
        }
    }
}

extension User {
    var jsonValue: [String: Any] {
        var jsonObject = [String: Any]()
        jsonObject["id"] = self.id
        jsonObject["firstName"] = self.firstName
        jsonObject["lastName"] = self.lastName
        jsonObject["birthDate"] = self.birthDate
        jsonObject["gender"] = self.gender
        jsonObject["height"] = self.height
        jsonObject["weight"] = self.weight
        return jsonObject
    }
}
