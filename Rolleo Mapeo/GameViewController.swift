//
//  GameViewController.swift
//  Rolleo Mapeo
//
//  Created by Mathias I Nielsen on 11/10/2018.
//  Copyright © 2018 Mathias I Nielsen. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeView), name: NSNotification.Name(rawValue:"stop"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showDeathPopup), name: NSNotification.Name(rawValue: "death"), object: nil)
        //NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "stop"), object: nil, queue: OperationQueue.main){(notification) in
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    //change this for level select
    
    @objc func changeView(_ notification: Notification){
        let info0 = notification.userInfo?["level"] as! Int
        if info0 == 1 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyBoard.instantiateViewController(withIdentifier: "MainMenu") as! MainMenuViewController
            self.present(secondViewController, animated: false, completion: nil)
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func showDeathPopup(){
        
    
        let deathPopUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "deathPopup") as! PopUpViewController
        self.addChild(deathPopUp)
        
        deathPopUp.view.frame = self.view.frame
        self.view.addSubview(deathPopUp.view)
        deathPopUp.didMove(toParent: self)
        
        
        
    }
}
