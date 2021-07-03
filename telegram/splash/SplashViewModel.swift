//
//  SplashViewModel.swift
//  telegram
//
//  Created by Zalkar on 29/6/21.
//

import Foundation
import FirebaseAuth

protocol SplashDelegate: AnyObject {
    func showMain()
    func showAuth()
}

class SplashViewModel: BaseViewModel {
    
    private weak var delegate: SplashDelegate?
    
    init(delegate: SplashDelegate) {
        self.delegate = delegate
    }
    
    func checkUser(){
        if FirebaseAuth.Auth.auth().currentUser != nil {
            delegate?.showMain()
        } else {
            delegate?.showAuth()
        }
    }
}
