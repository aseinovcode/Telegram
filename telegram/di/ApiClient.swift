//
//  ApiClient.swift
//  telegram
//
//  Created by Zalkar on 29/6/21.
//

import Foundation

class ApiClient {
    
    private static let shared = ApiClient()
    
    static func newInstanse() -> ApiClient {  //?????????/
        return shared
    }
}
