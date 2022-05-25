//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    // MARK: - Outlets/Properties
    
    private var userid: String?
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var header: UILabel!
    @IBOutlet private weak var body: UILabel!
    @IBOutlet private weak var bubbleView: UIView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = NamedColors.alabaster
        header.backgroundColor = header.superview?.backgroundColor
        
        bubbleView.backgroundColor = .white
        bubbleView.layer.cornerRadius = 8
        body.backgroundColor = bubbleView.backgroundColor
        body.numberOfLines = 0
        
        avatarImage.layer.cornerRadius = 25
    }
    
    // MARK: - Public
    
    func setCellData(userid: String, avatarImage: UIImage, header: String, body: String) {
        self.userid = userid
        self.avatarImage.image = avatarImage
        self.header.text = header
        self.body.text = body
    }
    
}

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Setup cell to match mockup
 *
 * 2) Include user's avatar image
 **/
