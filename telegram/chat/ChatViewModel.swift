//
//  MainViewModel.swift
//  telegram
//
//  Created by User on 25/6/21.
//

import Foundation
import FirebaseAuth

protocol ChatDelegate: AnyObject {
    func showUpdateChat()
    func showAuth()
}

class ChatViewModel: BaseViewModel {
    
    private weak var delegate: ChatDelegate?
    
    var chats: [ChatModel] = []
    
    init(delegate: ChatDelegate) {
        self.delegate = delegate
    }
    
    func loadChat() {
        getAllUsers()
    }
    
    private func getAllUsers() {
        DatabaseManager.shared.getAllUsers(copletion: {[weak self] result in
            switch result {
            case .success(let usersCollection):
                let results = try! result.get()
            
                results.forEach { (item) in
                    
                }
                
                DispatchQueue.main.async {
                    self?.delegate?.showUpdateChat()
                }
            case  .failure(let error):
                print("failed to load:\(error)")
            }
        })
    }
}
