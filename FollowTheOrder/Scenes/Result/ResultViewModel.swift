//
//  ResultViewModel.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 12.01.2022.
//

import UIKit
import SpriteKit

final class ResultViewModel {
    let level = UserDefaults.standard.integer(forKey: "level")
    private let networkManager = NetworkManager()
    
    var wishes: String?
    
    func fetchWishes(result: GameResult) {
        if result == .win || result == .nextLevel {
            networkManager.fetchAWishes { data in
                guard let data = data?.fortune else { return }
                self.wishes = data
            }
        }
    }
    
    func setupFontSize(wishes: String, node: SKLabelNode) {
        if wishes.count > 800 {
            node.fontSize = 12
        } else if wishes.count > 500 {
            node.fontSize = 15
        } else if wishes.count > 300 {
            node.fontSize = 18
        } else {
            node.fontSize = 20
        }
    }

}
