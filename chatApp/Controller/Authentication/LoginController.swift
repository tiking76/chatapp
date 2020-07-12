//
// Created by 舘佳紀 on 2020/07/11.
// Copyright (c) 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit

class LoginController : UIViewController {

    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()


    //xibみたいなことをやってる。
    private lazy var emailContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "envelope")!, textField: emilTextField)
    }()


    //xibみたいなことをやってる。
    private lazy var passwordContainerView : InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
    }()

    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        return button
    }()

    private let emilTextField : CustomTextField = {
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
        let attributeTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributeTitle.append(NSAttributedString(string: "Sign Up", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white]))

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
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)

        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32,paddingBottom: 32, paddingRight: 32)
    }

    //グラデーションをかけてる Pink X purple
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}