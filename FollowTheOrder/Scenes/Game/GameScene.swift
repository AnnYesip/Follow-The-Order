//
//  GameScene.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 11.01.2022.
//

import SpriteKit
import GameplayKit

final class GameScene: SKScene {
    
    private let level = UserDefaults.standard.string(forKey: "level")
    private var gameLayer: SKNode!
    private var levelTimerLabel = SKLabelNode(fontNamed: "ArialMT")
    private var maxX : CGFloat = 0.0
    private var maxY : CGFloat = 0.0
    
    private var answerArray = [SKLabelNode]()
    private var objArray: Set<SKLabelNode> = []
    
    private var levelTimerValue: Int = 3 {
        didSet {
            levelTimerLabel.text = "\(levelTimerValue)"
        }
    }
    
    // MARK: - didMove
    override func didMove(to view: SKView) {
        maxX = frame.size.width - 50
        maxY = frame.size.height - 100
        
        setupNode()
    }
    
    // MARK: - setup scene
    private func setupNode() {
        //setup background
        let background = SKSpriteNode(imageNamed: "menuBackground")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = -1
        background.name = "background"
        addChild(background)
        
        // level label
        let levelLabel = SKLabelNode(fontNamed: "AmericanTypewriter")
        levelLabel.fontColor = UIColor.white
        levelLabel.fontSize = 30
        levelLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - 100)
        levelLabel.zPosition = 2
        levelLabel.horizontalAlignmentMode = .center
        levelLabel.text = "Level \(level ?? " ")"
        addChild(levelLabel)
        
        //timer label
        setupTimeLabel()
        addChild(levelTimerLabel)
        startTimer()
        
        objArray = generateNode(numberOfNode: 5)
        gameLayer = SKNode()
        gameLayer.isHidden = true
        gameLayer.zPosition = 1
        gameLayer.isUserInteractionEnabled = true
        addChild(gameLayer)
        
        for ob in objArray {
            ob.position = gemerateCoordinate()
            ob.fontSize = 100
            gameLayer.addChild(ob)
        }
    }
    
    private func startTimer() {
        //timer
        let wait = SKAction.wait(forDuration: 1) // change countdown speed here
        
        let block = SKAction.run({
            [unowned self] in
            if self.levelTimerValue > 0 {
                self.levelTimerValue -= 1
            } else {
                self.removeAction(forKey: "countdown")
                self.levelTimerLabel.isHidden = true
                gameLayer.isHidden = false
                // start to animate nodes
                animateNodes(objArray)
            }
        })
        
        let sequence = SKAction.sequence([wait, block])
        run(SKAction.repeatForever(sequence), withKey: "countdown")
    }
    
    private func generateNode(numberOfNode: Int ) -> Set<SKLabelNode> {
        let fruits = ["🍊", "🍎", "🍍","🍏","🍑", "🥑", "🍓", "🍋"]
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
    
    private func gemerateCoordinate()  -> CGPoint {
        let xPos = CGFloat( Float(arc4random()) / Float(UINT32_MAX)) * maxX
        let yPos = CGFloat( Float(arc4random()) / Float(UINT32_MAX)) * maxY
        return CGPoint(x: xPos, y: yPos)
    }
    
    private func setupTimeLabel() {
        levelTimerLabel.fontColor = SKColor.orange
        levelTimerLabel.fontSize = 75
        levelTimerLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        levelTimerLabel.text = "\(levelTimerValue)"
    }
    
    // MARK: - animateNodes
    private func animateNodes(_ nodes: Set<SKLabelNode>) {
        for (index, node) in nodes.enumerated() {
            let actionSequence = SKAction.increaseAndDecreaseAnimation(
                withTimeInternal: index)
            
            node.run(actionSequence, completion: {
                if index == self.answerArray.count - 1 {
                    // enable the touch after the animation ends
                    self.gameLayer.isUserInteractionEnabled = false
                }
            })
            answerArray.append(node)
            print(answerArray)
        }
        
    }
    
    // MARK: - touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        if action(forKey: "countdown") != nil {
            print("tap on timer")
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            let node : SKNode = self.atPoint(location)
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            if node.name == answerArray.first?.name {
                print("✅ нажат \(answerArray.first?.name ?? " ")  и это правильно ✅ ")
                let animation = SKAction.increaseAndDecreaseAnimation(
                    withTimeInternal: 0)
                node.run(animation)
                answerArray.removeFirst()
                if answerArray.isEmpty {
                    print(" 🎉 СЛЕДУЮЩИЙ УРОВЕНЬ 🎉")
                    let scene: SKScene = ResultScene(size: self.size,
                                                     result: .nextLevel)
                    self.view?.presentScene(scene,
                                            transition: transition)
                } else if answerArray.isEmpty && level == "3" {
                    print(" 🎉 ВЫ ВЫИГРАЛИ 🎉")
                    let scene: SKScene = ResultScene(size: self.size,
                                                     result: .nextLevel)
                    self.view?.presentScene(scene,
                                            transition: transition)
                }
            } else if node.name == "background" {
                print("⚠️ вы нажали на фон ⚠️")
            } else {
                print("❌ неправильный выбор ❌")
                if view != nil {
                    let scene: SKScene = ResultScene(size: self.size,
                                                     result: .gameOver)
                    self.view?.presentScene(scene,
                                            transition: transition)
                }
            }
            
        }
    }
    
    
    deinit {
        print("Deallocating \(self)")
    }
}
