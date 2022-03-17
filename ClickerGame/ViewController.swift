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

class ViewController: UIViewController {
    
    let database = Firestore.firestore()
    var personalHighScores : [Game] = []
    var timer = Timer()
    var date = Date()
    var timeNumber = 20.00
    var score = 0
    
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
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
            var newScore = Game(s: score, d: date)
            personalHighScores.append(newScore)
            personalHighScores.sort(by: {$0.score > $1.score})
            for game in personalHighScores {
                print(game.score)
            }
        }
    }
    
    func writeData(text: String){
        let docRef = database.document("player/score")
        docRef.setData(["self": personalHighScores])
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
        timeNumber = 20.00
        timeLabel.text = "00:20.00"
        score = 0
        scoreLabel.text = String(0)
    }
    

}

