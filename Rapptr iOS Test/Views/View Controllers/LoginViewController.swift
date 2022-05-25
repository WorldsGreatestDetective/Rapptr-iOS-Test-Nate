//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var loginView: LoginView?
    private var loginViewModel: LoginViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        setView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Injection
    
    func setLoginView(view: LoginView) {
        loginView = view
        loginView!.setController(controller: self)
    }
    
    func setView() {
        let newView = LoginView(frame: self.view.frame)
        
        setLoginView(view: newView)
        self.view = newView
    }
    
    func setLoginViewModel(viewModel: LoginViewModel) {
        loginViewModel = viewModel
    }
    
    // MARK: - Actions
    
    func backAction() {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    func loginAction() {
        guard let loginView = self.loginView else {return} // change to if-let?
        
        guard let email = loginView.getEmail() else {return}
        guard let password = loginView.getPassword() else {return}
        
        let viewModel = LoginViewModel(email: email, password: password)
        setLoginViewModel(viewModel: viewModel)
        loginViewModel!.makeLoginRequest()
        
        if loginViewModel!.didResponseSucceed == true {
            presentAlertSuccess()
        } else /*if loginViewModel!.didResponseSucceed == false*/{
            presentAlertError()
        }
    }
    
    private func presentAlertError() {
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let alertController = UIAlertController(title: "Login Unsuccessful", message: "username or password invalid", preferredStyle: .alert)
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func presentAlertSuccess() {
        if let calculatedTime = CalculatedTimeForLogin.calculatedTimeInterval {
            let dismissAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            let alertController = UIAlertController(title: "Login Successful", message: "login took \(calculatedTime) milliseconds", preferredStyle: .alert)
            
            alertController.addAction(dismissAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            let dismissAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            let alertController = UIAlertController(title: "Login Successful", message: "login took an unknown amount of time", preferredStyle: .alert)
            
            alertController.addAction(dismissAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
}

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Take email and password input from the user
 *
 * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
 *
 * 4) Calculate how long the API call took in milliseconds
 *
 * 5) If the response is an error display the error in a UIAlertController
 *
 * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
 *
 * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
 **/
