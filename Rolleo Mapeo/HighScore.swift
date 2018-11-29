//
//  HighScore.swift
//  Rolleo Mapeo
//
//  Created by Mathias I Nielsen on 01/11/2018.
//  Copyright © 2018 Mathias I Nielsen. All rights reserved.
//

import Foundation



class HighScore {

    static let hs = HighScore()
    var currentTime = Date()
    var passed = true
  
    
    var highStruct = HighscoreStruct()
    
    
    init() {
        
        
    }
    
    
    func start() {
        currentTime = Date()
        passed = true
    }
    
    func stop(level: Int){
        if passed {
             highStruct.times.append(Double(Date().timeIntervalSince(currentTime)))
            passed = false
                 Storage.store(highStruct, to: .documents, as: "times.json")
            
            
        }
    }
}
