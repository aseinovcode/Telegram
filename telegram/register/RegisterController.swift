//
//  RegisterController.swift
//  telegram
//
//  Created by Zalkar on 28/6/21.
//

import UIKit
import SnapKit
import FirebaseAuth

class RegisterController: UIViewController {
    
    private lazy var viewModel: RegisterViewModel = {
        return RegisterViewModel(delegate: self)
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
    
    private let FirstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
//        field.delegate = self
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name"
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self,
                         action: #selector(registerButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Register"
        
        setupRegUI()
        
    }
    
    func setupRegUI() {
        view.addSubview(FirstNameField)
        view.addSubview(lastNameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)

        FirstNameField.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(lastNameField.snp.top).offset(-10)
            make.width.equalTo(view.frame.width / 1.0)
            make.height.equalTo(50)
        }

        lastNameField.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(emailField.snp.top).offset(-10)
            make.width.equalTo(view.frame.width / 1.0)
            make.height.equalTo(50)
        }
        
        emailField.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(view.frame.width / 1.0)
            make.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.width.equalTo(view.frame.width / 1.0)
            make.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.width.equalTo(view.frame.width / 1.0)
            make.height.equalTo(50)
        }
        
    }
    
    @objc private func registerButtonTapped(){
        viewModel.register(password: passwordField.text ?? String(), email: emailField.text ?? String(), lastName: String(), fertsName: String())
    }
}


extension RegisterController: RegisterDelegate {
    func registerSucces() {
        navigationController?.pushViewController(ChatController(), animated: true)
    }
    
    func registerError(message: String) {
        print(message)
    }
}
