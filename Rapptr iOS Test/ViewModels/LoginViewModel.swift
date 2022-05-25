//
//  LoginViewModel.swift
//  Rapptr iOS Test
//
//  Created by Nathan Reilly on 5/7/22.
//

import Foundation

class LoginViewModel {
    
    // MARK: - Private
    
    private let loginClient: LoginClient
    private let login: Login
    
    // MARK: - Public
    
    var email: String
    var password: String
    
    var didResponseSucceed: Bool?
    
    // MARK: - Init
    
    init(email: String, password: String) {
        
        // .login takes in parameters upon init
        // Parameters are passed to the client
        
        self.email = email
        self.password = password
        
        self.login = Login(email: email, password: password)
        self.loginClient = LoginClient(login: login)
    }
    
    // MARK: - Methods
    
    func makeLoginRequest() {
        loginClient.didLoginRequestSucceed(completion: { responseDict in
            if responseDict["code"] == "Success" {
                self.didResponseSucceed = true
            } else /*if responseDict["code"] == "Error"*/ {
                self.didResponseSucceed = false
            }
        })
    }
}
