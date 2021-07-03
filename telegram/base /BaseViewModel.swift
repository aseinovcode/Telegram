//
//  BaseViewModel.swift
//  telegram
//
//  Created by Zalkar on 29/6/21.
//

import Foundation

class BaseViewModel {
    
}

extension BaseViewModel {
    var repository: Repository { get { Repository.newInstanse() } }
    var apiClient: ApiClient { get { ApiClient.newInstanse() } }
}
