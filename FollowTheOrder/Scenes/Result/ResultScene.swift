//
//  ResultScene.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 11.01.2022.
//

import SpriteKit

enum Result: String {
    case win
    case gameOver
    case nextLevel
}

final class ResultScene: SKScene {
    
    private let level = UserDefaults.standard.integer(forKey: "level")
    private var result: Result?
    private var actionBurron = SKSpriteNode()
    
    // MARK: - init
    init(size: CGSize, result: Result) {
        super.init(size: size)
        self.result = result
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - didMove
    override func didMove(to view: SKView) {
        guard let result = result else { return }
        loadGameOverScene(result: result)
    }
    
    // MARK: - loadGameOverScene
    private func loadGameOverScene(result: Result) {
        /// !!!! подтянуть эту надпись !!!!
        //  A Smith \u0026 Wesson beats four aces
        //  http://yerkee.com/api/fortune
        
        
        let background = SKSpriteNode(imageNamed: "menuBackground")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        let node = SKNode()
        node.alpha = 1
        node.zPosition = 2
        addChild(node)
        
        let opsLabel = SKLabelNode(fontNamed: "AmericanTypewriter")
        opsLabel.fontColor = .white
        opsLabel.fontSize = 30
        opsLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - 100)
        opsLabel.zPosition = 2
        opsLabel.horizontalAlignmentMode = .center
        node.addChild(opsLabel)
        
        let label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        label.fontColor = .white
        label.fontSize = 40
        label.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - 200)
        label.zPosition = 2
        label.numberOfLines = 0
        label.horizontalAlignmentMode = .center
        node.addChild(label)
        
        switch result {
        case .win:
            opsLabel.text = "YOU WON!"
            label.text = " !!! ТУТ НАДО ПОДТЯНУТЬ ТО ПОЖЕЛАНИЕ !!!"
            actionBurron = SKSpriteNode(imageNamed: "playButton")
        case .gameOver:
            opsLabel.text = "Oooops"
            label.text = "Game Over"
            actionBurron = SKSpriteNode(imageNamed: "tryAgain")
            
        case .nextLevel:
            opsLabel.text = "Nice"
            label.text = "Tap to start \n next level"
            actionBurron = SKSpriteNode(imageNamed: "playButton")
        }
        
        
        actionBurron.size = CGSize(width: 100, height: 100)
        actionBurron.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - 400)
        actionBurron.zPosition = 2
        node.addChild(actionBurron)
        
    }
    
    
    
    
    // MARK: - touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        if let touch = touches.first {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == actionBurron {
                switch result {
                case .win:
                    if view != nil {
                        UserDefaults.standard.set(level, forKey: "bestResult")
                        let scene: SKScene = MenuScene(size: self.size)
                        self.view?.presentScene(scene, transition: transition)
                    }
                case .gameOver:
                    UserDefaults.standard.set(1, forKey: "level")
                    if view != nil {
                        let scene: SKScene = MenuScene(size: self.size)
                        self.view?.presentScene(scene, transition: transition)
                    }
                case .nextLevel:
                    UserDefaults.standard.set(level + 1, forKey: "level")
                    
                    if level > UserDefaults.standard.integer(forKey: "bestResult") {
                        UserDefaults.standard.set(level, forKey: "bestResult")
                    }
                    if view != nil {
                        let scene: SKScene = GameScene(size: self.size)
                        self.view?.presentScene(scene, transition: transition)
                    }
                case .none:
                    break
                }
            }
        }
    }
    
    
    deinit {
        print("Deallocating \(self)")
    }
}
