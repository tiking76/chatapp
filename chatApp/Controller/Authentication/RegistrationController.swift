//
// Created by 舘佳紀 on 2020/07/11.
// Copyright (c) 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit

class RegistrationController : UIViewController {
    
    private var viewModel = RegistrationViewModel()

    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    
    private lazy var EmailContainerView : InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: EmailTextField)
    }()
    
    
    private let EmailTextField = CustomTextField(placeholder: "Email")
    
    
    private lazy var FullNameContainerView : InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: FullNameTextField)
    }()
    
    
    private let FullNameTextField = CustomTextField(placeholder: "Full Name")
    
    
    private lazy var UserNameContainerView : InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: UserNameTextField)
    }()
    
    
    private let UserNameTextField = CustomTextField(placeholder: "Username")
    
    
    private lazy var PasswordContainerView : InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: PasswordTextField)
    }()
    
    
    private let PasswordTextField : CustomTextField = {
        let tf = CustomTextField(placeholder: "password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    private let SignUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        return button
    }()
    
    
    private let AlreadyHaveAccountButton: UIButton = {
           let button = UIButton(type: .system)
           let attributeTitle = NSMutableAttributedString(string: "Already have an account? ",
                                                          attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
           attributeTitle.append(NSAttributedString(string: "Log In",
                                                    attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white]))
           button.setAttributedTitle(attributeTitle, for: .normal)
           button.addTarget(self, action: #selector(handleShowLogIn), for: .touchDragInside)
           return button
       }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    
    @objc func textDidChange(sender: UITextField) {
        if sender == EmailTextField {
            viewModel.email = sender.text
        } else if sender == FullNameTextField {
            viewModel.fullName = sender.text
        } else if sender == UserNameTextField {
            viewModel.userName = sender.text
        } else {
            viewModel.passwprd = sender.text
        }
        checkFormStatus()
    }
    
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @objc func handleShowLogIn() {
        navigationController?.popViewController(animated: true)
    }

    
    func configureUI() {
        configureGradientLayer()
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        plusPhotoButton.setDimensions(width: 120, height: 120)
        let stack = UIStackView(arrangedSubviews: [EmailContainerView,
                                                   FullNameContainerView,
                                                   UserNameContainerView,
                                                   PasswordContainerView,
                                                   SignUpButton])
        //垂直に置く
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 32,
                     paddingLeft: 32,
                     paddingRight: 32)
        view.addSubview(AlreadyHaveAccountButton)
        AlreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.rightAnchor,
                                        paddingLeft: 32,
                                        paddingBottom: 32,
                                        paddingRight: 32)
    }
    
    
    func configureNotificationObservers() {
        EmailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        FullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        UserNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        PasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}


//写真を丸くしたとアルバムからの選択
extension RegistrationController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 115 / 2
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleToFill
        dismiss(animated: true, completion: nil)
    }
}


extension RegistrationController : AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsVaild {
            SignUpButton.isEnabled = true
            SignUpButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }else {
            SignUpButton.isEnabled = false
            SignUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
