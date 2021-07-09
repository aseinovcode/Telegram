//
//  DialogViewModel.swift
//  telegram
//
//  Created by User on 25/6/21.
//

import Foundation

protocol DialogDelegate: AnyObject {
    func showChat()
    func fillData(chat: ChatModel?)
    func showAllMessage()
}

class DialogViewModel: BaseViewModel {
    
    private weak var delegate: DialogDelegate?
    
    private var chat: ChatModel?
    
    var allMessage: [DialogMessage] = []
    
    init(delegate: DialogDelegate) {
        self.delegate = delegate
    }
    
    func fill(chat: ChatModel){
        self.chat = chat
        
        allMessage.append(DialogMessage(message: "test", typeMessage: .MyMessage))
        allMessage.append(DialogMessage(message: "test", typeMessage: .MyMessage))
        allMessage.append(DialogMessage(message: "test", typeMessage: .MyMessage))
        allMessage.append(DialogMessage(message: "test", typeMessage: .OtherMessage))
        allMessage.append(DialogMessage(message: "test", typeMessage: .OtherMessage))
        allMessage.append(DialogMessage(message: "test", typeMessage: .MyMessage))
        allMessage.append(DialogMessage(message: "test", typeMessage: .MyMessage))

        delegate?.showAllMessage()
        delegate?.fillData(chat: chat)
    }



}
