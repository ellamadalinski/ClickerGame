//
//  Game.swift
//  ClickerGame
//
//  Created by ELLA MADALINSKI on 3/17/22.
//

import Foundation
public class Game : Codable{
    var score : Int
    var date : String

    init(s:Int, d: String){
        score = s
        date = d
    }
}

public class Statics : Codable {
    static var personalHighScores : [Game] = []
    static var overallHighScores : [Game] = []
}
