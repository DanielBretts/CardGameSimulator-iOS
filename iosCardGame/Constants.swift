//
//  Constants.swift
//  iosCardGame
//
//  Created by amit lupo  on 7/16/24.
//

import Foundation

struct Constants{
    struct WelcomeScreen{
        static let USER_DEFAULTS_KEY: String = "username"
        static let PLAYER_SIDE_KEY: String = "playerSide"
    }
    
    struct GameScreen{
        static let ROUNDS: Int = 10
        static let AI_LABEL: String = "AI"
        static let WINNER_KEY: String = "winner"
        static let WINNER_SCORE: String = "winnerScore"
        
    }

}
