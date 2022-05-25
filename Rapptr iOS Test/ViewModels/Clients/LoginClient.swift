//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//
//
/**
 On scalability and OCP:
 
 This class was built specifically for the login view model. A more scalable super (final) class which obeys open-closed principle would simply take in .url and .headers as init parameters foregoing the need to alter .url directly (which violates ocp)
 
 Said class can be used for any networking client class and one could also make mock subclasses to unit test said class.
**/
//

import Foundation
import Alamofire

class LoginClient {
    
    let url = "http://dev.rapptrlabs.com/Tests/scripts/login.php"
    let headers: HTTPHeaders = ["Access-Control-Allow-Origin" : "*"]
    let login: Login
    var urlRequest: URLRequest
   
    init(login: Login) {
        self.login = login
        do {
            self.urlRequest = try! URLRequest(url: self.url, method: .post, headers: headers)
            self.urlRequest.httpBody = "email=\(login.email)&password=\(login.password)".data(using: .utf8)
        } catch {
            print(error)
        }
    }
    
    func didLoginRequestSucceed(completion: @escaping (Dictionary<String, String>) -> Void) {
        var calculatedTime = CalculatedTimeForLogin()
        
        let request = AF.request(urlRequest)
        request.responseDecodable(of: Dictionary<String, String>.self) { (response) in
            guard let responseDict = response.value else {return}
            completion(responseDict)
        }
        
        calculatedTime.endDate = Date()
    }
    
}


/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
*/
