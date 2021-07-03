//
//  ChatModel.swift
//  telegram
//
//  Created by User on 25/6/21.
//

import Foundation

class ChatModel {
    var name: String
    var lastMessage: String
    var urlImage: String
    
    init(name: String, lastMessage: String, urlImage: String) {
        self.name = name
        self.lastMessage = lastMessage
        self.urlImage = urlImage
    }
}
