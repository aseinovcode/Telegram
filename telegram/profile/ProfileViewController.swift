//
//  ProfileViewController.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    
    private lazy var viewModel: ProfileViewModel = {
        return ProfileViewModel(delegate: self)
    }()
    
    private lazy var profileTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
//        view.tableHeaderView = createTableHeader()
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        
        setupUI()
       
    }
    
//    func createTableHeader() -> UIView?{
//        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
//            return nil
//        }
//        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
//        let filename = safeEmail + "_profile_picture.png"
//        let path = "images/" + filename
//        let headerView = UIView(frame: CGRect(x: 0,
//                                        y: 0,
//                                        width: 300,
//                                        height: 300))
//        headerView.backgroundColor = .link
//        let imageView = UIImageView(frame:  CGRect(x: 75,
//                                                   y: 75,
//                                                   width: 150,
//                                                   height: 150))
//
//        imageView.contentMode = .scaleAspectFill
//        imageView.backgroundColor = .white
//        imageView.layer.borderColor = UIColor.white.cgColor
//        imageView.layer.borderWidth = 3
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 25
//        headerView.addSubview(imageView)
//        StorageManager.shared.downloadURL(for: path, completion: {[weak self] result in
//            switch result {
//            case .success(let url):
//                self?.downloadImage(imageView: imageView, url: url)
//            case .failure(let error):
//                print("Failed to get download url:\(error)")
//            }
//        })
//        return view
//    }
    
    func downloadImage(imageView: UIImageView, url: URL){
        URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
        }).resume()
    }
    
    func setupUI() {
        
        view.addSubview(profileTableView)
        profileTableView.snp.makeConstraints{ (make) in
            make.top.bottom.left.right.equalTo(view)
        }
    }
    
    @objc func clickLogOut(view: UIButton) {
        viewModel.logout()
    }
}

extension ProfileViewController:  ProfileDelegate{
    
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
