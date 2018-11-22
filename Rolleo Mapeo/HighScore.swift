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
    var times: [Int]!
    var currentTime = Date()
    let decoder = JSONDecoder()
    var firstTime = true
    let fileName = "highscores.txt"
    
    private init(){
    }
    
    func start(){
        if firstTime{
            var jsonString = [String]()
            
            do {
                jsonString = try String(contentsOf: getDocumentsDirectory().appendingPathComponent(fileName), encoding: .utf8).components(separatedBy: " ")
            } catch {
                print("Something went wrong trying to get the highscores file")
                times = [Int]()
            }
            
            for highscore in jsonString{
                times.append(Int(highscore)!)
            }
            firstTime = false
        }
        currentTime = Date()
    }
    
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask()).first!
        return file
    }
    
    func stop(level: Int) {
        if passed {
            times.append(Int(Date().timeIntervalSince(currentTime)))
            
            let jsonData: Data? = try? JSONEncoder().encode(times)
            let jsonString = String(bytes: jsonData!, encoding: .utf8)
            
            do {
                try jsonString?.write(to: getDocumentsDirectory().appendingPathComponent(fileName), atomically: true, encoding: .utf8)
            } catch {
                print("oh boy")
            }
        }
    }
}
