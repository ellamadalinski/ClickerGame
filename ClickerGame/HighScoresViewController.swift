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
    
    let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overallTableViewOutlet.delegate = self
        overallTableViewOutlet.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view appeared")
        let docRef = database.document("player/game")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil
            else {
                return
            }
        
            guard let scores = data["score"] as? [Int] else{
                return
            }
            Statics.top10 = scores
            self.overallTableViewOutlet.reloadData()
        }
        let docRef2 = database.document("player/user")
        docRef2.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil
            else {
                return
            }
        
            guard let names = data["name"] as? [String] else{
                return
            }
        
            Statics.top10Names = names
            self.overallTableViewOutlet.reloadData()
        }
        
        //overallTableViewOutlet.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Statics.top10.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overall", for: indexPath)
        print(Statics.top10)
        if Statics.top10 != []{
            cell.textLabel?.text = String(Statics.top10[indexPath.row])
            cell.detailTextLabel?.text = Statics.top10Names[indexPath.row]
        }
        return cell
    }
    
}
