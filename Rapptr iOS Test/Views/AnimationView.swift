//
//  AnimationView.swift
//  Rapptr iOS Test
//
//  Created by Nathan Reilly on 5/8/22.
//

import UIKit

class AnimationView: UIView, UIDragInteractionDelegate {
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 50, y: 230, width: 310, height: 68))
        
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "ic_logo")
        imageView.alpha = 0
        
        return imageView
    }()
    
    private let fadeInButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("FADE IN", for: .normal)
        button.tintColor = NamedColors.darkBlue
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        let config = UIButton.Configuration.filled()
        button.configuration = config
        
        return button
    }()
    
    private var dragInteraction: UIDragInteraction?
    private weak var controller: AnimationViewController?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = NamedColors.alabaster
        
        addSubview(fadeInButton)
        addSubview(logoImage)
        
        fadeInButton.addTarget(self, action: #selector(fadeInButtonTapped), for: .touchUpInside)
        
        activateConstraints()
        dragInteraction = UIDragInteraction(delegate: self)
        logoImage.addInteraction(dragInteraction!)
    }
    
    private func activateConstraints() {
        let constraintsArray: [NSLayoutConstraint] = [fadeInButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor), fadeInButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), fadeInButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30)]
        
        NSLayoutConstraint.activate(constraintsArray)
    }
    
    private func fadeInLogo() {
        UIView.animate(withDuration: 1.5, delay: 0, options: .allowUserInteraction, animations: {
            self.logoImage.alpha = 1
        }, completion: nil)
    }
    
    @objc private func fadeInButtonTapped() {
        fadeInLogo()
    }
    
    // MARK: - UIDragInteractionDelegate
    
    internal func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = logoImage.image else { return [] }

        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image
            
        return [item]
    }
    
    // MARK: - Public
    
    func setController(controller: AnimationViewController) {
        self.controller = controller
    }

}
