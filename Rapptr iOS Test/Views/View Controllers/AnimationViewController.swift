//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.
//
//  Be sure to double click-hold on image when using simulator to drag image
//

import UIKit

class AnimationViewController: UIViewController {
        
    private var animationView: AnimationView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        
        setView()
    }
    
    // MARK: - Injection
    
    func setView() {
        let newView = AnimationView(frame: self.view.frame)
        
        setAnimationView(view: newView)
        self.view = animationView
    }
    
    func setAnimationView(view: AnimationView) {
        animationView = view
    }
}

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
 *
 * 3) User should be able to drag the logo around the screen with his/her fingers
 *
 * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation
 *    section in Swfit to show off your skills. Anything your heart desires!
 *
 */
