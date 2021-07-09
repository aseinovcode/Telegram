//
//  DialogMessage.swift
//  telegram
//
//  Created by Zalkar on 9/7/21.
//

import Foundation

class DialogMessage {
    
    var message: String
    var typeMessage: TypeMessage
    
    enum TypeMessage {
        case MyMessage
        case OtherMessage
    }
    
    init(message: String, typeMessage: TypeMessage) {
        self.message = message
        self.typeMessage = typeMessage
    }
}
