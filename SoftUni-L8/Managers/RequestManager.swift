//
//  RequestManager.swift
//  SoftUni-L8
//
//  Created by Martin Kuvandzhiev on 13.10.21.
//

import Foundation
import Alamofire
import SwiftUI

enum NetworkErrors: Error {
    case cannotParseData
}

class RequestManager {
    static let backgroundQueue = DispatchQueue(label: "Data queue", qos: .default)
    
    class func fetchAllUsers(completion: @escaping((_ error: Error?)->Void)) {
        AF.request(
            "https://softuni-rest-2021-default-rtdb.europe-west1.firebasedatabase.app/users/.json",
            method: .get)
            .responseJSON { result in
                guard result.error == nil else {
                    completion(result.error)
                    return
                }
                
                guard let resultValue = result.value else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
                
                guard let usersDict = resultValue as? [String: [String: Any]] else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
                
                for aUserDict in usersDict {
                    let user = User(value: aUserDict.value)
                    
                    backgroundQueue.async {
                        let backgroundRealm = LocalDataManager.backgroundRealm(queue: backgroundQueue)
                        try? backgroundRealm.write({
                            backgroundRealm.add(user, update: .all)
                        })
                    }
                }
                
                NotificationCenter.default.post(name: .userDataLoaded, object: nil)
                completion(nil)
            }
    }
    
    class func uploadUser(user: User, completion: @escaping((_ error: Error?)->Void)) {
        let userJson = user.jsonValue
        
        AF.request("https://softuni-rest-2021-default-rtdb.europe-west1.firebasedatabase.app/users/.json",
                   method: .post,
                   parameters: userJson,
                   encoding: JSONEncoding.default).responseJSON { result in
            guard result.error == nil else {
                completion(result.error)
                return
            }
            
            guard let resultValue = result.value else {
                completion(NetworkErrors.cannotParseData)
                return
            }
            
            guard let userDict = resultValue as? [String: Any] else {
                completion(NetworkErrors.cannotParseData)
                return
            }
            
            print(userDict)
            
            completion(nil)
        }
    }
}
