//
//  ProfileDelegate.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import Foundation

protocol ProfileDelegate: AnyObject {
    func showAuth()
}

class ProfileViewModel: BaseViewModel {
    
    private weak var delegate: ProfileDelegate?
    
    init(delegate: ProfileDelegate) {
        self.delegate = delegate
    }
    
    public var data = ["Logout"]
    
    func logout() {
        do {
            try apiClient.logout()
            
            self.delegate?.showAuth()
        } catch {
            print("signOut error")
        }
    }
}
