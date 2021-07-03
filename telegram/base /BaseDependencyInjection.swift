//
//  BaseDependencyInjection.swift
//  telegram
//
//  Created by Zalkar on 29/6/21.
//

import Foundation

class BaseDependencyInjection<T> {
    
    private var shared: T = return BaseDependencyInjection<T>() as! T
    
    
    static func newInstanse() -> T {
        return shared as! T
    }
}
