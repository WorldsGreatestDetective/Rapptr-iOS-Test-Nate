//
//  ChatViewModel.swift
//  Rapptr iOS Test
//
//  Created by Nathan Reilly on 5/10/22.
//

import Foundation
import UIKit

class ChatViewModel {
    
    // MARK: - Private
    
    private var chatClient: ChatClient
    private var messages: [Message]?
    
    // MARK: - Public
    
    var messageCount: Int = 0
    
    var userids: [String] = []
    var usernames: [String] = []
    var textBodies: [String] = []
    var avatarImages: [UIImage] = []
    
    // MARK: - Init
    
    init() {
        self.chatClient = ChatClient()
        self.messages = nil // Sets messages to nil since will hold no value upon init
    }
    
    // MARK: - Methods
    
    func parseDataForMessages(completion: @escaping ([Message]) -> Void) {
        chatClient.fetchChatData() { [unowned self] (responseDict, errorType) in
            
            if errorType != nil {return}
            guard let responseDict = responseDict else {return}

            self.messages = []
            var newMessage = Message()
            guard let responseArray = responseDict["data"] else {return}
            
            for dict in responseArray {
                newMessage.userID = dict["user_id"] ?? "Error"
                newMessage.username = dict["name"] ?? "Error"
                newMessage.text = dict["message"] ?? "Error"
                newMessage.avatarURL = URL(string: dict["avatar_url"] ?? "Error")
                
                if newMessage.userID == "Error", newMessage.username == "Error", newMessage.text == "Error", newMessage.avatarURL?.absoluteString == "Error" {
                    return
                } else {
                    self.messages!.append(newMessage)
                }
            }
            
            completion(self.messages!)
        }
    }
    
    func setChatData(withMessages messages: [Message]) -> ErrorTypeForChat? {
        setMessages(messages: messages)
        
        for message in self.messages! { 
            userids.append(message.userID!)
            usernames.append(message.username!)
            textBodies.append(message.text!)
        }
        if let errorType = setChatImages() {
            return errorType
        } else {
            return nil
        }
    }
    
    func setChatImages() -> ErrorTypeForChat? {
        var image: UIImage? = UIImage()
        var imageData = Data()
        
        guard let messages = self.messages else {return .parseError}
        
        do {
            for message in messages {
                imageData = try Data(contentsOf: message.avatarURL!)
                image = UIImage(data: imageData) ?? nil
                
                if image != nil {
                    avatarImages.append(image!)
                } else {
                    return .parseError
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func setMessageCount(count: Int) {
        self.messageCount = count
    }
    
    func setMessages(messages: [Message]) {
        self.messages = messages
    }
    
}
