//
//  HighScoreTableViewController.swift
//  Rolleo Mapeo
//
//  Created by Daniel Viktor Schmidt on 29/11/2018.
//  Copyright © 2018 Mathias I Nielsen. All rights reserved.
//

import UIKit

class HighScoreTableViewController: UITableViewController {
    
    var timesArray = HighscoreStruct()
    var tableArray = [Double]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timesArray = Storage.retrieve("times.json", from: .documents, as: HighscoreStruct.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableArray = timesArray.get()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        let times = tableArray[indexPath.row]
        cell.textLabel?.text = String(times)
        return cell
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
 
    
}
