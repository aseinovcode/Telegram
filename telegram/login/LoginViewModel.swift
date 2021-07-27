//
//  LoginViewModel.swift
//  telegram
//
//  Created by Zalkar on 28/6/21.
//

import Foundation

protocol LoginDelegate: AnyObject {
    func loginSucces()
    func loginError()
}

class LoginViewModel: BaseViewModel {
    
    private weak var delegate: LoginDelegate?
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
    }
    
    func login(password: String, email: String) {
        apiClient.login(password: password, email: email, completion: { [self] authResult, error in
            if authResult == nil && error != nil {
                delegate?.loginError()
            } else {
                delegate?.loginSucces()
                Repository.shared.userDefaults.set(email, forKey: "email")
            }
        })
    }
}

