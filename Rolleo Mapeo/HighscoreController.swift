//
//  HighscoreController.swift
//  Rolleo Mapeo
//
//  Created by Mathias I Nielsen on 25/10/2018.
//  Copyright © 2018 Mathias I Nielsen. All rights reserved.
//

import UIKit

class HighscoreController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clearHighscores(_ sender: Any) {
        HighScore.hs.clear()
    }
    
}
