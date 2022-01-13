//
//  GameViewModel.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 12.01.2022.
//

import UIKit
import SpriteKit

final class GameViewModel {
    
    let level = UserDefaults.standard.integer(forKey: "level")
    
    func generateNode(numberOfNode: Int) -> Set<SKLabelNode> {
        let fruits = ["🍊", "🍎", "🍍", "🍏", "🍑", "🥑", "🍓", "🍋", "🥝", "🥭", "🥥", "🍐", "🍉", "🍇", "🍌"]
        var objArray: Set<SKLabelNode> = []
        
        if numberOfNode <= fruits.count {
            for fruit in fruits.prefix(numberOfNode) {
                let obj = SKLabelNode(text: fruit)
                obj.name = fruit
                objArray.update(with: obj)
            }
        }
        return objArray
    }
    
    func gemerateCoordinate(maxX: CGFloat, maxY: CGFloat)  -> CGPoint {
        let xPos = CGFloat( Float(arc4random()) / Float(UINT32_MAX)) * maxX
        let yPos = CGFloat( Float(arc4random()) / Float(UINT32_MAX)) * maxY
        return CGPoint(x: xPos, y: yPos)
    }
 
}
