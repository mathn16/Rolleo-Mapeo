//
//  MainMenuViewController.swift
//  Rolleo Mapeo
//
//  Created by Mathias I Nielsen on 25/10/2018.
//  Copyright © 2018 Mathias I Nielsen. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenuViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MainMenu") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
        }
        // Do any additional setup after loading the view.
    }
}
