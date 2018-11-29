//
//  HighscoreStruct.swift
//  Rolleo Mapeo
//
//  Created by Daniel Viktor Schmidt on 29/11/2018.
//  Copyright © 2018 Mathias I Nielsen. All rights reserved.
//

import Foundation

struct HighscoreStruct: Codable {

var times: [Double]
    
    init(){
        times = []
    }
    func get() -> [Double]{
        return times
    }
}

