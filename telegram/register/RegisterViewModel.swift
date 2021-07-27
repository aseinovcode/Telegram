//
//  RegisterViewModel.swift
//  telegram
//
//  Created by Zalkar on 28/6/21.
//

import UIKit
import FirebaseAuth

protocol RegisterDelegate: AnyObject {
    func registerSuccess()
    func registerError()
    func UserExists()
    func imageViewDel() -> UIImageView
}

class RegisterViewModel: BaseViewModel{
    
    private weak var delegate: RegisterDelegate?
    
    init(delegate: RegisterDelegate) {
        self.delegate = delegate
    }
    
    func register(firstName: String, lastName: String, email: String, password: String){
        
        DatabaseManager.shared.userExists(with: email, completion: { [self] exists in
            guard !exists else {
                // user already exists
                delegate?.UserExists()
                return
            } // ???????????????
            
            apiClient.register(password: password, email: email, completion: { [self] authResult, error in
                
                if authResult == nil && error != nil {
                    delegate?.registerError()
                } else {
                    delegate?.registerSuccess()
                }
                
                let chatUser = ChatAppUser(firsName: firstName,
                                           lastName: lastName,
                                           emailAddress: email,
                                           id: authResult!.user.uid)
                
                DatabaseManager.shared.insertUser(with: chatUser, completion: { success in
                    if success {
                        guard let image = delegate?.imageViewDel().image,
                              let data = image.pngData() else {
                            return
                        }
                        let filename = chatUser.profilePictureFileName
                        StorageManager.shared.profilePicUpload(with: data, filename: filename, completion: {result in
                            switch result {
                            case .success(let downloadUrl):
                                Repository.shared.userDefaults.set(downloadUrl, forKey: "profile_pic_url")
                                print(downloadUrl)
                            case .failure(let error):
                                print("storage manager error: \(error)")
                            }
                        })
                    }
                })
            })
        })
    }

}
