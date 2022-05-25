//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//
//  See \LoginClient for more on scalability and obeying OCP
//

import Foundation
import Alamofire

class ChatClient {
    
    func fetchChatData(completion: @escaping (Dictionary<String, Array<Dictionary<String, String>>>?, ErrorTypeForChat?) -> Void) {
        let request = AF.request("http://dev.rapptrlabs.com/Tests/scripts/chat_log.php")
        
        // Decoding response into nested type fitting the data format given
        
        request.responseDecodable(of: Dictionary<String, Array<Dictionary<String, String>>>.self) { (response) in
            guard let responseDict = response.value else {completion(nil, .parseError); return}
            completion(responseDict, nil)
        }
    }
    
}

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 */
