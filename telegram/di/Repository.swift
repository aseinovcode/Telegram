//
//  Repository.swift
//  telegram
//
//  Created by Zalkar on 29/6/21.
//

import Foundation
import FirebaseAuth

class Repository {
    
    static let shared = Repository()
    
    public let userDefaults = UserDefaults.standard
    
    static func newInstanse() -> Repository {
        return shared
    }
    
    var user: User? {
        get {
            return FirebaseAuth.Auth.auth().currentUser
        }
    }
}
