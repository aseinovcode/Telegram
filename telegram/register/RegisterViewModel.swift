//
//  RegisterViewModel.swift
//  telegram
//
//  Created by Zalkar on 28/6/21.
//

import Foundation
import FirebaseAuth

protocol RegisterDelegate: AnyObject {
    func registerSucces()
    func registerError()
}

class RegisterViewModel: BaseViewModel {
    
    private weak var delegate: RegisterDelegate?
    
    init(delegate: RegisterDelegate) {
        self.delegate = delegate
    }
    
    func register(password: String, email: String, lastName: String, fertsName: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [self] authResult, error in
            if authResult == nil && error != nil{
                delegate?.registerError()
            } else {
                self.delegate?.registerSucces()
            }
        })
    }
}
