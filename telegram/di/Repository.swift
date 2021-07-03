//
//  Repository.swift
//  telegram
//
//  Created by Zalkar on 29/6/21.
//

import Foundation

class Repository {
    
    private static let shared = Repository()
    
    private let userDefaults = UserDefaults.standard
    
    static func newInstanse() -> Repository {
        return shared
    }
    
    var userToken: String? {
        get {
            return userDefaults.string(forKey: Constraints.Key.token)
        }
        set(token) {
            userDefaults.set(token, forKey: Constraints.Key.token)
        }
    }
}
