//
//  DatabaseManager.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import Foundation
import FirebaseDatabase
import Firebase

final class DatabaseManager: BaseViewModel{
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    private let uid = Auth.auth().currentUser
    
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
 
}

extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)){
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    public func insertUser(with user: ChatAppUser, completion: @escaping(Bool) -> Void){
        database.child(user.safeEmail).setValue([
            "first_name": user.firsName,
            "last_name": user.lastName
        ], withCompletionBlock: {error, _ in
            guard error == nil else {
                print("failed to write database")
                completion(false)
                return
            }
            
            self.database.child("users").observeSingleEvent(of: .value, with: {snapshot in
                if var usersCollection = snapshot.value as? [[String : String]] {
                    //append to user dictionary
                    let newElement = [
                        "name": user.firsName + " " + user.lastName,
                        "email": user.emailAddress
                    ]
                    usersCollection.append(newElement)
                    self.database.child("users").setValue(usersCollection, withCompletionBlock: {error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        completion(true)
                    })
                }
                else{
                    //create that array
                    let newCollection: [[String : String]] = [
                        [
                            "name": user.firsName + " " + user.lastName,
                            "email": user.emailAddress
                        ]
                    ]
                    self.database.child("users").setValue(newCollection, withCompletionBlock: {error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        completion(true)
                    })
                }
            })
        })
    }
    
    public func getAllUsers(copletion: @escaping (Result<[[String : String]], Error>) -> Void){
        database.child("users").observeSingleEvent(of: .value, with: {snapshot in
            guard let value = snapshot.value as? [[String : String]] else {
                copletion(.failure(DatabaseError.failedToFetch))
                return
            }
            copletion(.success(value))
        })
    }
    
    public enum DatabaseError: Error {
        case failedToFetch
    }
    
//    public func getUsers(onSucces: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void){
//
//        guard let uid = uid else {
//            print ("user not found")
//            return
//        }
//
//        database.child("users").observe(.value, with: { (snapshot) in
//            if let dictionary = (snapshot.value as! [String: Any]) != nil
//        }) {(error) in
//            onError(error)
//        }
//    }
    
}

struct ChatAppUser {
    let firsName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }
}

