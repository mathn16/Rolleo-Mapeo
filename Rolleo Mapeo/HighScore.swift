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
    let encoder = JSONEncoder()
    let path: URL
    let test:[Int] = [17, 33, 64]
    
    private init(){
        path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName)
        
        let jsonData: Data? = try? encoder.encode(test)
        do {
            try jsonData?.write(to: path)
            print("Create file was succesful")
        } catch {
            print("Create file was not succesful")
        }
        
        
    }
    
    func start(){
        if firstTime{
            var jsonString = [String]()
            
            do {
                print(path)
                jsonString = try String(contentsOf: path, encoding: .utf8).components(separatedBy: " ")
            } catch {
                print("Something went wrong trying to get the highscores file")
                times = [Int]()
            }
            for s in jsonString {
                if s == nil {
                    times.append(Int(s as String)!)
                }
            }
            firstTime = false
        }
        currentTime = Date()
    }
    
    func stop(level: Int) {
        if passed {
            times.append(Int(Date().timeIntervalSince(currentTime)))
            
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
