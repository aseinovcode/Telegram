//
//  ProfileViewController.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import UIKit
import SnapKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    private lazy var viewModel: ProfileViewModel = {
        return ProfileViewModel(delegate: self)
    }()
    
    private lazy var profileTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var imageProfile: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(imageProfile)
        imageProfile.snp.makeConstraints { (make) in
            make.width.height.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeArea.top).offset(16)
        }
        
        view.addSubview(profileTableView)
        profileTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageProfile.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func clickLogOut(view: UIButton) {
        viewModel.logout()
    }
}

extension ProfileViewController:  ProfileDelegate {
    func profileImage() -> UIImageView {
        return imageProfile
    }
    
    func showAuth() {
        navigationController?.pushViewController(LoginController(), animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.viewModel.data[indexPath.row]
        let cell = ProfileCell()
        cell.loadData(text: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.logout()
    }
}



//    func dowloadImage(){
//        guard let email = Repository.shared.userDefaults.value(forKey: "email") as? String else {
//            return
//        }
//        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
//        let filename = safeEmail + "_profile_picture.png"
//        let path = "images/" + filename
//
//       StorageManager.shared.downloadURL(for: path, completion: {[weak self] result in
//            switch result {
//            case .success(let url):
//                self?.downloadImage(url: url)
//            case .failure(let error):
//                print("Failed to get download url:\(error)")
//            }
//        })
//    }
//
//    func downloadImage(url: URL){
//        URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            DispatchQueue.main.async {
//                print(data)
//
//                let image = UIImage(data: data)
//                self.imageProfile.image = image
//            }
//        }).resume()
//    }
    
