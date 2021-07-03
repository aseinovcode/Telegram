//
//  DialogViewModel.swift
//  telegram
//
//  Created by User on 25/6/21.
//

import Foundation

protocol DialogDelegate: AnyObject {
    func showData()
    func fillData(chat: ChatModel?)
}

class DialogViewModel: BaseViewModel {
    
    private weak var delegate: DialogDelegate?
    
    private var chat: ChatModel?
    
    init(delegate: DialogDelegate) {
        self.delegate = delegate
    }
    
    func fill(chat: ChatModel) {
        self.chat = chat
        
        delegate?.fillData(chat: chat)
    }
}
