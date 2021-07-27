//
//  ProfileDelegate.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import Foundation
import Kingfisher

protocol ProfileDelegate: AnyObject {
    func showAuth()
    func profileImage() -> UIImageView
}

class ProfileViewModel: BaseViewModel {
    
    private weak var delegate: ProfileDelegate?
    
    init(delegate: ProfileDelegate) {
        self.delegate = delegate
    }
    
    public var data = ["Logout"]
    
    func logout() {
        do {
            try apiClient.logout()
            
            self.delegate?.showAuth()
        } catch {
            print("signOut error")
        }
    }



    func dowloadImage(){
        guard let email = Repository.shared.userDefaults.value(forKey: "email") as? String else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        let filename = safeEmail + "_profile_picture.png"
        let path = "images/" + filename
        
        StorageManager.shared.downloadURL(for: path, completion: {[weak self] result in
             switch result {
             case .success(let url):
                 self?.downloadImage(url: url)
             case .failure(let error):
                 print("Failed to get download url:\(error)")
             }
         })
    }

    func downloadImage(url: URL){
        URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                print((data))
    
                let image = UIImage(data: data)
                self.delegate?.profileImage().image = image
            }
        }).resume()
    }
}


//func downloadImage(url: URL){
//    URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
//        guard let data = data, error == nil else {
//            return
//        }
//        DispatchQueue.main.async {
//            print(data)
//
//            let image = UIImage(data: data)
//            image?.kf.set
//            self.imageProfile.image = image
//        }
//    }).resume()
//}


