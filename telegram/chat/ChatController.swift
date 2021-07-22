//
//  ViewController.swift
//  telegram
//
//  Created by User on 25/6/21.
//

import UIKit
import SnapKit

class ChatController: UIViewController {

    //
    //
    //                    YES  --> Main -- (caht, all users, profile) all permission
    //                     |         |
    // Splash (check) - chech auth   |----------
    //                     |                   |
    //                     NO  --> Auth -> check is succes auth
    //
    //
    
    private lazy var viewModel: ChatViewModel = {
        return ChatViewModel(delegate: self)
    }()
    
    private lazy var chatTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.loadChat()
    }
    
    private func setupUI() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapComposeButton))
        
        title = "Chats"
        view.backgroundColor = UIColor.white
        navigationItem.hidesBackButton = true
        
        view.addSubview(chatTableView)
        chatTableView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }

    }
    @objc func didTapComposeButton() {
        let vc = NewDialogViewController()
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }

}

extension ChatController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DialogViewController.newInstanse(chat: self.viewModel.chats[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.chats.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = self.viewModel.chats[indexPath.row]
        let cell = ChatCell()
        
        cell.fill(chat: chat)   //??????????/
        
        return cell
    }
}

extension ChatController: ChatDelegate {
    func showUpdateChat() {
        self.chatTableView.reloadData()
    }
    
    func showAuth() {
        navigationController?.pushViewController(LoginController(), animated: true)
    }
}

