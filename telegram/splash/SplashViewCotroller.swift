//
//  SplashViewCotroller.swift
//  telegram
//
//  Created by User on 25/6/21.
//

import UIKit
import Firebase

class SplashViewCotroller: UIViewController {
    
    private lazy var viewModel: SplashViewModel = {
        return SplashViewModel(delegate: self)
    }()
    
    override func viewDidLoad() {
        viewModel.checkUser()
    }
}

extension SplashViewCotroller: SplashDelegate {
    func showMain() {
        navigationController?.pushViewController(ChatController(), animated: true)
    }
    
    func showAuth() {
        navigationController?.pushViewController(LoginController(), animated: true)
    }
}
