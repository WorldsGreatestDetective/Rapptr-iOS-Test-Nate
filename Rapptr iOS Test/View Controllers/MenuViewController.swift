//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: Properties
    
    // view and viewModel marked as private to keep view & viewModel seperate
    // Both defined as optionals to ensure both are injected before accessed
    
    private var menuView: MenuViewProtocol? // See MenuViewProtocol in \Protocols for explanation!
    private var loginViewModel: LoginViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coding Tasks"
        
        setView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    // MARK: - Injection
    
    func setMenuView(view: MenuViewProtocol) { // Method for injecting the view
        menuView = view
        menuView!.setController(controller: self) // Setting controller on the view
    }
    
    func setView() {
        let newView = MenuView(frame: self.view.frame) // Setting the views frame
        
        setMenuView(view: newView) // Injecting the view
        self.view = newView
    }
    
    func setLoginViewModel(viewModel: LoginViewModel) { // Method for injecting the viewModel
        loginViewModel = viewModel
    }
    
    // MARK: - Actions
    
    func pushToLoginVC() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func pushToAnimationVC() {
        let animationViewController = AnimationViewController()
        navigationController?.pushViewController(animationViewController, animated: true)
    }
    
    func pushToChatVC() {
        let viewModel = ChatViewModel()
        let chatViewController = ChatViewController()
        
        chatViewController.setChatViewModel(viewModel: viewModel)
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
}

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 *
 * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
 *
 * 2) Use Autolayout to make sure all UI works for each resolution
 *
 * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
 *    provided code if necessary. It is ok to add any classes. This is your project now!
 *
 * 4) Read the additional instructions comments throughout the codebase, they will guide you.
 *
 * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
 *
 * Thank you and Good luck. - Rapptr Labs
 * =========================================================================================
 */
