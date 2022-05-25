//
//  MenuView.swift
//  Rapptr iOS Test
//
//  Created by Nathan Reilly on 5/3/22.
//
//

import UIKit

class MenuView: UIView, MenuViewProtocol { // See MenuViewProtocol in \Protocols for explanation!!
    
    // MARK: - Properties
    
    // View properties marked as private making properties only accesible by view controller through public methods if need be
    
    private let menuImage: UIImageView = { // subviews are returned through closures
        
        // configuring subview upon init
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        
        backgroundImage.image = UIImage(named: "bg_home_menu")
        backgroundImage.contentMode = .scaleAspectFill
        
        return backgroundImage
    }()
    
    private let chatButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("CHAT", for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(NamedColors.blackBlue, for: .normal)
        button.setImage(UIImage(named: "ic_chat"), for: .normal)
        button.contentHorizontalAlignment = .leading
        
        var config = UIButton.Configuration.gray()
        config.background.cornerRadius = 8
        config.imagePlacement = .leading
        config.imagePadding = 16
        config.baseBackgroundColor = NamedColors.alabasterFaded
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 0)
        button.configuration = config
        
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("LOGIN", for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(NamedColors.blackBlue, for: .normal)
        button.setImage(UIImage(named: "ic_login"), for: .normal)
        button.contentHorizontalAlignment = .leading
        
        var config = UIButton.Configuration.gray()
        config.background.cornerRadius = 8
        config.imagePlacement = .leading
        config.imagePadding = 16
        config.baseBackgroundColor = NamedColors.alabasterFaded
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 0)
        button.configuration = config
        
        return button
    }()
    
    private let animationButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("ANIMATION", for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(NamedColors.blackBlue, for: .normal)
        button.setImage(UIImage(named: "ic_animation"), for: .normal)
        button.contentHorizontalAlignment = .leading
        
        var config = UIButton.Configuration.gray()
        config.background.cornerRadius = 8
        config.imagePlacement = .leading
        config.imagePadding = 16
        config.baseBackgroundColor = NamedColors.alabasterFaded
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 0)
        button.configuration = config
        
        return button
    }()
    
    private let stackView = UIStackView()
    private weak var controller: MenuViewController? // weak reference to controller to avoid strong reference cycles
    
    // MARK: - Init

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = NamedColors.alabaster
        
        addSubview(menuImage)
        addSubview(stackView)
        
        configureSubViews()
        activateConstraints()
    }
    
    private func configureSubViews() { // Configuring subviews for autolayout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 24
        
        let fillerView = UIView()
        fillerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        
        let views: [UIView] = [chatButton,loginButton,animationButton]
        
        for button in views {
            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        }
        
        for view in views {
            stackView.addArrangedSubview(view)
        }
        stackView.addArrangedSubview(fillerView)
        
        addTargetsToButtons()
    }
    
    private func activateConstraints() {
        
        let constraintsArray: [NSLayoutConstraint] = [stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 227), stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 227), /*stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 30),*/ stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30), stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)]
        
        NSLayoutConstraint.activate(constraintsArray)
    }
    
    private func addTargetsToButtons() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        animationButton.addTarget(self, action: #selector(animationButtonTapped), for: .touchUpInside)
        chatButton.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Button target methods
    
    @objc private func chatButtonTapped() {
        controller?.pushToChatVC()
    }
    
    @objc private func loginButtonTapped() {
        controller?.pushToLoginVC()
    }
    
    @objc private func animationButtonTapped() {
        controller?.pushToAnimationVC()
    }
    
    // MARK: - Public
    
    func setController(controller: MenuViewController) { // Public method to set controller property for the view to access its respective controller
        self.controller = controller
    }

}
