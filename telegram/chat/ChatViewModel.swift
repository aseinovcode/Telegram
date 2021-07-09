//
//  MainViewModel.swift
//  telegram
//
//  Created by User on 25/6/21.
//

import Foundation
import FirebaseAuth

protocol ChatDelegate: AnyObject {
    func showChat(chats: [ChatModel])
    func showAuth()
}

class ChatViewModel: BaseViewModel {
    
    private weak var delegate: ChatDelegate?
    
    private var chats: [ChatModel] = []   //?????????????/
    
    init(delegate: ChatDelegate) {
        self.delegate = delegate
    }
    
    func logout() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            
            self.delegate?.showAuth()
        } catch {
            print("signOut error")
        }
    }
    
    func loadChat() {
        chats.append(ChatModel(name: "Eldar", lastMessage: "Ты где?", urlImage: "https://png.pngtree.com/png-clipart/20190924/original/pngtree-businessman-user-avatar-free-vector-png-image_4827807.jpg"))
        chats.append(ChatModel(name: "Talgat", lastMessage: "im ios delelopet", urlImage: "https://png.pngtree.com/png-clipart/20190924/original/pngtree-businessman-user-avatar-free-vector-png-image_4827807.jpg"))
        
        delegate?.showChat(chats: chats)
    }
}
