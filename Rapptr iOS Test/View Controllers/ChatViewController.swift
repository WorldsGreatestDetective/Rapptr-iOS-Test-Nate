//
//  ChatViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    private var chatViewModel: ChatViewModel?
    private var tableView: UITableView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = NamedColors.alabaster
        title = "Chat"
        
        guard let chatViewModel = chatViewModel else { return }

        chatViewModel.parseDataForMessages { [unowned self] (messages) in
            if let errorType = chatViewModel.setChatData(withMessages: messages) {
                presentErrorAlert(ofType: errorType)
            } else {
                DispatchQueue.main.async {
                    chatViewModel.setMessageCount(count: messages.count)
                    configureTable()
                    tableView?.reloadData()
                }
            }
        }
    }
    
    // MARK: - Public
    
    func setChatViewModel(viewModel: ChatViewModel) {
        chatViewModel = viewModel
    }
    
    // MARK: - Private
    
    private func presentErrorAlert(ofType errorType: ErrorTypeForChat) {
        switch errorType {
        case .parseError:
            let dismissAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            let alertController = UIAlertController(title: "Message fetch unsuccessful", message: "message could not be parsed", preferredStyle: .alert)
            
            alertController.addAction(dismissAction)
            
            present(alertController, animated: true, completion: nil)
        default:
            break
        }
    }
    
    private func configureTable() {
        self.tableView = UITableView(frame: self.view.frame)
        guard let tableView = self.tableView else {return}

        view.addSubview(tableView)
        tableView.backgroundColor = view.backgroundColor
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - UITableViewDataSource
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell
        
        guard let chatViewModel = chatViewModel else {return cell!}
        
        cell?.setCellData(userid: chatViewModel.userids[indexPath.row], avatarImage: chatViewModel.avatarImages[indexPath.row], header: chatViewModel.usernames[indexPath.row], body: chatViewModel.textBodies[indexPath.row])
        return cell!
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let messageCount = chatViewModel?.messageCount else {return 0}
        return messageCount
    }
    
    // MARK: - UITableViewDelegate
    internal func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Using the following endpoint, fetch chat data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 * 3) Parse the chat data using 'Message' model
 *
 **/
