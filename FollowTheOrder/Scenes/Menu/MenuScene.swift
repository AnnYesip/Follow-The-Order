//
//  MenuScene.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 11.01.2022.
//

import SpriteKit

final class MenuScene: SKScene {
    let background = SKSpriteNode(imageNamed: "background")
    let score = SKLabelNode(fontNamed: "AmericanTypewriter")
    private var playButton = SKSpriteNode()
    private let bestResult = UserDefaults.standard.integer(forKey: "bestResult")
    
    // MARK: - didMove
    override func didMove(to view: SKView) {
        start()
    }
    
    // MARK: - setup scene
    private func start() {
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        score.text = "\(Strings.bestScore) \(bestResult)"
        score.fontSize = 35
        score.fontColor = .green
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
        
        guard let touch = touches.first else { return }
        let pos = touch.location(in: self)
        let node = self.atPoint(pos)
        guard view != nil else { return }
        
        if node == playButton {
            let transition: SKTransition = SKTransition.fade(withDuration: 1)
            let scene: SKScene = GameScene(size: self.size, viewModel: GameViewModel())
            //                    let scene: SKScene = ResultScene(size: self.size, viewModel: ResultViewModel(), result: .gameOver)
            self.view?.presentScene(scene, transition: transition)
        }
        guard view != nil else { return }
        
    }
    
    deinit {
        print("Deallocating \(self)")
    }
}
