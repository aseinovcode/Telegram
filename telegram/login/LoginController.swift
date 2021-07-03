//
//  LoginController.swift
//  telegram
//
//  Created by Zalkar on 28/6/21.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginController: UIViewController {

    private lazy var viewModel: LoginViewModel = {
        return LoginViewModel(delegate: self)
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
//        field.delegate = self
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
//        Field.delegate = self
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self,
                         action: #selector(loginButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log In"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))

        
        setupUI()
        
    }
    
    func setupUI() {
        navigationItem.hidesBackButton = true
                
        view.addSubview(emailField)
        emailField.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview().offset(-30)
            make.width.equalTo(view.frame.width / 1.0)
            make.height.equalTo(50)
        }
        
        view.addSubview(passwordField)
        passwordField.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.width.equalTo(view.frame.width / 1.0)
            make.height.equalTo(50)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.width.equalTo(view.frame.width / 1.0)
            make.height.equalTo(50)
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(emailField.snp.top).offset(-15)
            make.width.equalTo(view.frame.width / 3.0)
            make.height.equalTo(view.frame.width / 3.0)
        }
    }
    
    @objc private func loginButtonTapped(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
     
        viewModel.login(password: passwordField.text ?? String(), email: emailField.text ?? String())
    }
    
    @objc func didTapRegister(){
        let vc = RegisterController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginController: LoginDelegate {
    func loginSucces() {
        navigationController?.pushViewController(ChatController(), animated: true)
    }
    
    func loginError(message: String) {
        print(message)
    }
}

