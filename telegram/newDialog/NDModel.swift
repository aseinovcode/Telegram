//
//  NDModel.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import Foundation

class NDModel {
    
    var name: String
    var urlImage: String
    
    init(name: String, lastMessage: String, urlImage: String) {
        
        self.name = name
        self.urlImage = urlImage
    }

}
