//
// Created by 舘佳紀 on 2020/07/11.
// Copyright (c) 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD


protocol AuthenticationControllerProtocol {
    func checkFormStatus()
}

class LoginController : UIViewController {
    
    private var viewModel = LoginViewModel()

    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()

    
    //xibみたいなことをやってる。
    private lazy var emailContainerView: InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
    }()


    //xibみたいなことをやってる。
    private lazy var passwordContainerView : InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
    }()

    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    

    private let emailTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "Email")
        return textField
    }()

    
    private let passwordTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "password")
        textField.isSecureTextEntry = true
        return textField
    }()


    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributeTitle = NSMutableAttributedString(string: "Don't have an account? ",
                                                       attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributeTitle.append(NSAttributedString(string: "Sign Up",
                                                 attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributeTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchDragInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    @objc func handleShowSignUp() {
        let vc = RegistrationController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.passwprd = sender.text
        }
        checkFormStatus()
    }
    
    
    //基本的なLogin処理の書き方
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text?.lowercased() else { return }
        
        showLoader(true, withText: "Loggin in")
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Faild to login with error \(error.localizedDescription)")
                self.showLoader(false)
                return
            }
            
            self.showLoader(false)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingBottom: 32)
        iconImage.setDimensions(width: 120, height: 120)
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        //垂直に置く
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 32,
                     paddingLeft: 32,
                     paddingRight: 32)
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor,
                                     paddingLeft: 32,
                                     paddingBottom: 32,
                                     paddingRight: 32)
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}



extension LoginController : AuthenticationControllerProtocol {
    
    func checkFormStatus() {
        if viewModel.formIsVaild {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
