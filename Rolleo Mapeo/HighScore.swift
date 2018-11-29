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
    
    var passed = true
    var times: [Double]!
    var currentTime = Date()
    let decoder = JSONDecoder()
    var firstTime = true
    let fileName = "highscores.txt"
    let encoder = JSONEncoder()
    let path: URL
    let test:[Int] = [17, 33, 64]
    
    private init(){
        let jsonString: String
        path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName)
        
        let jsonData: Data? = try? encoder.encode(test)
        do {
            try jsonData?.write(to: path)
        } catch {
            print("Create file was not succesful")
        }
        print(path)
        let jsonDataFromFile: Data = try! Data(contentsOf: path)
        print(jsonDataFromFile)
        if jsonDataFromFile.count != 0 {
            jsonString = try! decoder.decode(String.self, from: jsonDataFromFile)
        
            if jsonString.count != 0 {
                let highScores = jsonString.split(separator: " ")
                for hs in highScores {
                    times.append(Double(String(hs))!)
                }
            }
        }
        
    }
    
    func start(){
        currentTime = Date()
    }
    
    func stop(level: Int) {
        if passed {
            times.append(Double(Date().timeIntervalSince(currentTime)))
            
            let jsonData: Data? = try? encoder.encode(times)
            let jsonString = String(bytes: jsonData!, encoding: .utf8)
            
            
            do {
                try jsonString?.write(to: path, atomically: true, encoding: .utf8)
            } catch {
                print("oh boy")
            }
        }
    }
}
