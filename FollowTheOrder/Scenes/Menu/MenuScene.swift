//
//  MenuScene.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 11.01.2022.
//

import SpriteKit

final class MenuScene: SKScene {
    
    private var playButton = SKSpriteNode()
    private let bestResult = UserDefaults.standard.integer(forKey: "bestResult")
    
    // MARK: - didMove
    override func didMove(to view: SKView) {
        start()
    }
    
    // MARK: - setup scene
    private func start() {
        let background = SKSpriteNode(imageNamed: "menuBackground")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        let score = SKLabelNode(fontNamed: "Chalkduster")
        score.text = "Best score: \(bestResult)"
        score.fontSize = 30
        score.fontColor = SKColor.green
        score.position = CGPoint(x: self.size.width / 2, y: self.size.height - 150)
        
        addChild(score)
        
        playButton = SKSpriteNode(imageNamed: "playButton")
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
        playButton.size = CGSize(width: 150, height: 150)
        self.addChild(playButton)
    }
    
    // MARK: - touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == playButton {
                if view != nil {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
    
    deinit {
        print("Deallocating \(self)")
    }
}
