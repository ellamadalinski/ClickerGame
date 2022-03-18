//
//  HighScoresViewController.swift
//  ClickerGame
//
//  Created by ELLA MADALINSKI on 3/16/22.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreData

class HighScoresViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    
    @IBOutlet weak var overallTableViewOutlet: UITableView!
    @IBOutlet weak var personalTableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overallTableViewOutlet.delegate = self
        overallTableViewOutlet.dataSource = self
        personalTableViewOutlet.delegate = self
        personalTableViewOutlet.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == overallTableViewOutlet{
            let cell = tableView.dequeueReusableCell(withIdentifier: "overall", for: indexPath)
            return cell
        }
        else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "personal", for: indexPath)
            cell.textLabel?.text = String(Statics.personalHighScores[indexPath.row].score)
                
            cell.detailTextLabel?.text = Statics.personalHighScores[indexPath.row].date
                
            return cell
        }
    }
    
}
