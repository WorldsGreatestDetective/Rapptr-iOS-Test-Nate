//
//  LoginView.swift
//  Rapptr iOS Test
//
//  Created by Nathan Reilly on 5/1/22.
//

import UIKit

class LoginView: UIView {
    
    private let loginImage: UIImageView = {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        
        backgroundImage.image = UIImage(named: "img_login") // configure for adaptivity
        backgroundImage.contentMode = .scaleAspectFill
        
        return backgroundImage
    }()
    
    private let emailField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.setLeftPaddingPoints(24)
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor : NamedColors.darkGray]
        let attributedText = NSAttributedString(string: "Email", attributes: attributes)
        textField.attributedPlaceholder = attributedText
        
        return textField
    }()
    
    private let passwordField: UITextField = {
        let textField = UITextField()
    
        textField.borderStyle = .roundedRect
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.setLeftPaddingPoints(24)
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor : NamedColors.darkGray]
        let attributedText = NSAttributedString(string: "Password", attributes: attributes)
        textField.attributedPlaceholder = attributedText
    
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LOGIN", for: .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 0
        
        var config = UIButton.Configuration.gray()
        config.titleAlignment = .center
        config.baseBackgroundColor = NamedColors.darkBlue
        button.configuration = config
        
        return button
    }()
    
    private let stackView = UIStackView()
    private weak var controller: LoginViewController? 

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = NamedColors.alabaster
        
        configureSubView()
        addSubview(loginImage)
        addSubview(stackView)
        
        activateConstraints()
    }
    
    private func configureSubView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 24
        
        let views: [UIView] = [emailField,passwordField,loginButton]
        
        for button in views {
            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        }
        for view in views {
            stackView.addArrangedSubview(view)
        }
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func activateConstraints() {
        let constraintsArray: [NSLayoutConstraint] = [stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 64), stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 30)]
        
        NSLayoutConstraint.activate(constraintsArray)
    }
    
    @objc private func loginButtonTapped() {
        controller!.loginAction()
    }
    
    // MARK: - Public
    
        // TODO: prevent user to enter emtpy text fields; see GRDBex-MVC
    
    func getEmail() -> String? {
        if let email = emailField.text {
            return email
        } else {
            return nil
        }
    }
    
    func getPassword() -> String? {
        if let password = passwordField.text {
            return password
        } else {
            return nil
        }
    }
    
    func setController(controller: LoginViewController) {
        self.controller = controller
    }

}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
