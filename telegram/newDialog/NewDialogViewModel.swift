//
//  NewDialogViewModel.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import Foundation
import FirebaseAuth

protocol NewDialogDelegate: AnyObject {
    func loadSucces()
    func loadError()
}

class NewDialogViewModel: BaseViewModel {
    
    private weak var delegate: NewDialogDelegate?
    
    init(delegate: NewDialogDelegate) {
        self.delegate = delegate
    }
    
    private var users = [[String : String]]()
    
    public var results = [[String : String]]()
    
    private var hasFetched = false
    
    func searchUsers(query: String) {
        //check if array has firebase results
        if hasFetched {
            //if it does: filter
            filterUsers(with: query)
        }else {
            //if not, fetch then filter
            DatabaseManager.shared.getAllUsers(copletion: {[weak self] result in
                switch result {
                case .success(let usersCollection):
                    self?.hasFetched = true
                    self?.users = usersCollection
                    self?.filterUsers(with: query)
                case  .failure(let error):
                    print("failed to load:\(error)")
                }
            })
        }
    }
    
    func getAllUsers() {
        DatabaseManager.shared.getAllUsers(copletion: {[weak self] result in
            switch result {
            case .success(let usersCollection):
                try! self?.results = result.get()
            
                for (index, element) in self!.results.enumerated() {
                    if element["id"]! == Auth.auth().currentUser!.uid {
                        self?.results.remove(at: index)
                    }
                }
                
                self?.updateUI()
            case  .failure(let error):
                print("failed to load:\(error)")
            }
        })
    }
    
    func filterUsers(with term: String) {
        //update the ui: either show results or show noresults label
        guard hasFetched else {
            return
        }
        
        let results: [[String : String]] = self.users.filter({
            guard let name = $0["name"]?.lowercased() else {
                return false
            }
            return name.hasPrefix(term.lowercased())
        })
        self.results = results
        
        updateUI()
    }
    
    func updateUI() {
        if results.isEmpty {
            delegate?.loadError()
        }else{
            delegate?.loadSucces()
        }
    }
}

