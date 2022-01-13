//
//  Constants.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 12.01.2022.
//

import UIKit

enum GameResult: String {
    case win
    case gameOver
    case nextLevel
    
    var resultString: String {
        switch self {
        case .win:
            return "YOU WON!"
        case .gameOver:
            return "Oooops"
        case .nextLevel:
            return "Great! Tap button to \n start next level"
        }
    }
    
    var commentLabel: String {
        switch self {
        case .win:
            return " "
        case .gameOver:
            return "Game Over"
        case .nextLevel:
            return " "
        }
    }
    
    var buttonImageName: String {
        switch self {
        case .win:
            return "playButton"
        case .gameOver:
            return "tryAgain"
        case .nextLevel:
            return "playButton"
        }
    }
    
}


