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
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.layer.masksToBounds = true     //округление изображения
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 50
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic(sender:)))
        imageView.addGestureRecognizer(tapGR)
        imageView.isUserInteractionEnabled = true
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
    
    private let firstNameField: UITextField = {
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
        view.addSubview(imageView)
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
        imageView.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(firstNameField.snp.top).offset(-15)
            make.width.equalTo(view.frame.width / 3.0)
            make.height.equalTo(view.frame.width / 3.0)
        }

        firstNameField.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(lastNameField.snp.top).offset(-10)
            make.width.equalTo(view.frame.width / 1.0)
            make.height.equalTo(50)
        }

        lastNameField.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview().offset(10)
            make.width.equalTo(view.frame.width / 1.0)
            make.height.equalTo(50)
        }
        
        emailField.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(lastNameField.snp.bottom).offset(10)
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
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        
        viewModel.register(firstName: firstNameField.text ?? String(), lastName: lastNameField.text ?? String(), email: emailField.text ?? String(), password: passwordField.text ?? String())
        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !lastName.isEmpty,
              password.count >= 6 else {
            registerError()
            return
        }
    }
    
    @objc private func didTapChangeProfilePic(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            presentPhotoActionSheet()
            print("tapped")
        }
    }
    
    func registerErrorAlert() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all informtion to create a new acount",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        
        present(alert, animated: true)
    }
    
    func userExistsAlert() {
        let alert = UIAlertController(title: "Woops",
                                      message: "User account for this user email address is already exists",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        
        present(alert, animated: true)
    }
}

extension RegisterController: RegisterDelegate {
    func registerSuccess() {
        navigationController?.pushViewController(ChatController(), animated: true)
    }
    
    
    func imageViewDel() -> UIImageView {
        return imageView
    }
    
    func UserExists() {
        return userExistsAlert()
    }
    
    func registerError() {
        return registerErrorAlert()
    }
}

extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile picture",
                                            message: "How would you like to select a picture",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Take a photo",
                                            style: .default,
                                            handler: {[weak self] _ in
                                                self?.presentCamera()
                                            }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose photo",
                                            style: .default,
                                            handler: {[weak self] _ in
                                                self?.photoPicker()
                                            }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func photoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
            self.imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

