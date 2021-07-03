//
//  DialogController.swift
//  telegram
//
//  Created by User on 25/6/21.
//

import UIKit

class DialogController: UIViewController {
    
    static func newInstanse(chat: ChatModel) -> DialogController {
        let viewController = DialogController()
        viewController.viewModel.fill(chat: chat)
        return viewController
    }
    
    private lazy var viewModel: DialogViewModel = {
        return DialogViewModel(delegate: self)
    }()
    
    private lazy var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var enterMessage: UITextField = {
        let view = UITextField()
        view.backgroundColor = .white
        view.placeholder = "message"
        view.layer.cornerRadius = 8
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        view.leftView = paddingView
        view.leftViewMode = .always
        return view
    }()
    
    private lazy var sendButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.setTitleColor(.blue, for: .normal)
        view.setTitle("Send", for: .normal)
        view.addTarget(self, action: #selector(clickSendMessage(view:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var messageTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var message: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(messageView)
        messageView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        messageView.addSubview(sendButton)
        sendButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-8)
            make.width.equalTo(45)
        }
        
        messageView.addSubview(enterMessage)
        enterMessage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
            make.right.equalTo(sendButton.snp.left).offset(-8)
        }
        
        view.addSubview(messageTableView)
        messageTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(messageView.snp.top)
        }
    }
    
    @objc func clickSendMessage(view: UIButton) {
        let messageSend = enterMessage.text ?? String()
        enterMessage.text = String()
        message.append(messageSend)
        
        messageTableView.reloadData()
    }
}

extension DialogController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageCell = UITableViewCell()
        messageCell.textLabel?.text = self.message[indexPath.row]
        return messageCell
    }
}

extension DialogController: DialogDelegate {
    func fillData(chat: ChatModel?) {
        self.title = chat?.name
    }
    
    func showData() {
        
    }
}
