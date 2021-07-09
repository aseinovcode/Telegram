//
//  ApiClient.swift
//  telegram
//
//  Created by Zalkar on 29/6/21.
//

import Foundation
import FirebaseAuth

class ApiClient {
    
    private static let shared = ApiClient()
    
    static func newInstanse() -> ApiClient { 
        return shared
    }
    
    func register(password: String, email: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func login(password: String, email: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func logout() throws {
        try FirebaseAuth.Auth.auth().signOut()
    }
        
    // homeworks
    
    // add method get all user (name profile image)
    
    // get All message in dialog
    
    // run real time data base
    
    // + add work chat
}
