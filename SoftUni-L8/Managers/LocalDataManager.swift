//
//  LocalDataManager.swift
//  SoftUni-L8
//
//  Created by Martin Kuvandzhiev on 20.10.21.
//

import Foundation
import RealmSwift

enum LocalDataManagerError: Error {
    case wrongQueue
}

class LocalDataManager {
    static let realm: Realm = {
        return try! initializeRealm(checkForMainThread: true)
    }()

    static func backgroundRealm(queue: DispatchQueue = DispatchQueue.main) -> Realm {
        return try! initializeRealm(checkForMainThread: false, queue: queue)
    }
    
    class func initializeRealm(checkForMainThread: Bool = false, queue: DispatchQueue = DispatchQueue.main) throws -> Realm {
        if checkForMainThread {
            guard OperationQueue.current?.underlyingQueue == DispatchQueue.main else {
                throw LocalDataManagerError.wrongQueue
            }
        }
        do {
            return try Realm(configuration: realmConfiguration, queue: queue)
        } catch {
            throw error
        }
    }
    
    static let realmConfiguration: Realm.Configuration = {
        var configuration = Realm.Configuration.defaultConfiguration
        
        configuration.schemaVersion = 2
        configuration.deleteRealmIfMigrationNeeded = true
        configuration.migrationBlock = { (migration, version) in
            
        }
        
        return configuration
    }()
}
