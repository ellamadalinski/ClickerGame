//
//  ViewController.swift
//  ClickerGame
//
//  Created by ELLA MADALINSKI on 3/14/22.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreData
import CoreAudio

class ViewController: UIViewController {
    
    let database = Firestore.firestore()
    var timer = Timer()
    var date = Date()
    var timeNumber = 20.00
    var score = 0
    var name = ""
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func update(){
        timeNumber-=0.01
        timeLabel.text = "00:\(round(timeNumber*100)/100)"
        if timeNumber <= 0.00{
            timer.invalidate()
            timeLabel.text = "00:0.00"
            
            let alert = UIAlertController(title: "Game Over", message: "You scored \(score) points", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Name"
            }
            let okAction = UIAlertAction(title: "Ok", style: .default){
                [weak alert] _ in
                guard let textFields = alert?.textFields
                else { return }
                
                if let text = textFields[0].text {
                    self.name = text
                }
                
                Statics.top10.append(self.score)
                Statics.top10.sort()
                Statics.top10.reverse()
                if let index = Statics.top10.firstIndex(of: self.score){
                    Statics.top10Names.insert(self.name, at: index)
                }
                if Statics.top10.count > 10{
                    Statics.top10.removeLast()
                    Statics.top10Names.removeLast()
                }
                self.writeArrayData(scores: Statics.top10)
                self.writeStringData(names: Statics.top10Names)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
            
            let dateNow = date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.dd.yyyy"
            let result = dateFormatter.string(from: dateNow)
            
//            Statics.top10.append(score)
//            Statics.top10.sort()
//            if let index = Statics.top10.firstIndex(of: score){
//                Statics.top10Names.insert(name, at: index)
//            }
//            if Statics.top10.count > 10{
//                Statics.top10.removeLast()
//                Statics.top10Names.removeLast()
//            }
//            writeArrayData(scores: Statics.top10)
//            writeStringData(names: Statics.top10Names)
        }
    }
    
    func writeArrayData(scores : [Int]){
        let docRef = database.document("player/game")
        docRef.setData(["score": scores])
    }
    
    func writeStringData(names : [String]){
        let docRef = database.document("player/user")
        docRef.setData(["name": names])
    }
    
    
    @IBAction func clickButtonAction(_ sender: UIButton) {
        if timeNumber == 20.00{
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            
        }
        if timeNumber<=20.00 && timeNumber>0.00{
            score += 1
            scoreLabel.text = String(score)
        }
        if timeNumber <= 0.00{
            timer.invalidate()
            timeLabel.text = "00:0.00"
        }
        
    }
    
    @IBAction func restartButtonAction(_ sender: UIButton) {
        timer.invalidate()
        timeNumber = 20.00
        timeLabel.text = "00:20.00"
        score = 0
        scoreLabel.text = String(0)
    }
    

}

