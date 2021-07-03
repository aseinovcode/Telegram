//
//  LoginViewModel.swift
//  telegram
//
//  Created by Zalkar on 28/6/21.
//

import Foundation
import FirebaseAuth

protocol LoginDelegate: AnyObject {
    func loginSucces()
    func loginError(message: String)
}

class LoginViewModel: BaseViewModel {
    
    private weak var delegate: LoginDelegate?
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
    }
    
    func login(password: String, email: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [self] authResult, error in
            guard let result = authResult, error == nil else {
                delegate?.loginError(message: "failed to login user with email:\(email)")
                return
            }

            delegate?.loginSucces()
        })
    }
}
