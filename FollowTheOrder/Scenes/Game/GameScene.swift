//
//  GameScene.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 11.01.2022.
//

import SpriteKit
import GameplayKit

final class GameScene: SKScene {
    
    private var gameLayer = SKNode()
    private let background = SKSpriteNode(imageNamed: "background")
    private var levelTimerLabel = SKLabelNode(fontNamed: "AmericanTypewriter")
    private let levelLabel = SKLabelNode(fontNamed: "AmericanTypewriter")
    private var maxX : CGFloat = 0.0
    private var maxY : CGFloat = 0.0
    
    private var answerArray = [SKLabelNode]()
    private var objArray: Set<SKLabelNode> = []
    
    private var levelTimerValue: Int = 3 {
        didSet {
            levelTimerLabel.text = "\(levelTimerValue)"
        }
    }
    private var viewModel: GameViewModel
    
    // MARK: - init
    init(size: CGSize, viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        maxX = frame.size.width - 50
        maxY = frame.size.height - 100
        
        setupNode()
    }
    
    // MARK: - touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node : SKNode = self.atPoint(location)
        let transition: SKTransition = SKTransition.fade(withDuration: 1)
        
        guard view != nil else { return }
        guard action(forKey: "countdown") == nil else { return }
        guard node.name != "background" else { return }
        
        if node.name == answerArray.first?.name {
            
            // correct answer
            let animation = SKAction.increaseAndDecreaseAnimation(
                withTimeInternal: 0)
            node.run(animation)
            answerArray.removeFirst()
            if answerArray.isEmpty && viewModel.level == 10 {
                // correct answer
                let scene: SKScene = ResultScene(size: self.size,
                                                 viewModel: ResultViewModel(),
                                                 result: .win)
                self.view?.presentScene(scene,
                                        transition: transition)
            } else if answerArray.isEmpty {
                // passed the last level
                let scene: SKScene = ResultScene(size: self.size,
                                                 viewModel: ResultViewModel(),
                                                 result: .nextLevel)
                self.view?.presentScene(scene,
                                        transition: transition)
            }
        } else {
            // wrong answer
            let scene: SKScene = ResultScene(size: self.size,
                                             viewModel: ResultViewModel(),
                                             result: .gameOver)
            self.view?.presentScene(scene,
                                    transition: transition)
            
        }
        
    }
    
    
    deinit {
        print("Deallocating \(self)")
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
    
    // MARK: - Private methods for setup scene
    
    private func setupNode() {
        setupBackground()
        setupLevelLabel()
        setupTimeLabel()
        startTimer()
        setupGameLayer()
        
        objArray = viewModel.generateNode(numberOfNode: viewModel.level + 4)
        
        for ob in objArray {
            ob.position = viewModel.gemerateCoordinate(maxX: maxX,
                                                       maxY: maxY)
            
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
    
    private func setupBackground() {
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = -1
        background.name = "background"
        addChild(background)
    }
    
    private func setupLevelLabel() {
        levelLabel.fontColor = UIColor.white
        levelLabel.fontSize = 30
        levelLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - 100)
        levelLabel.zPosition = 2
        levelLabel.horizontalAlignmentMode = .center
        levelLabel.text = "\(Strings.level) \(viewModel.level)"
        addChild(levelLabel)
    }
    
    private func setupTimeLabel() {
        levelTimerLabel.fontColor = .systemCyan
        levelTimerLabel.fontSize = 90
        levelTimerLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        levelTimerLabel.text = "\(levelTimerValue)"
        addChild(levelTimerLabel)
    }
    
    private func setupGameLayer() {
        gameLayer = SKNode()
        gameLayer.isHidden = true
        gameLayer.zPosition = 1
        gameLayer.isUserInteractionEnabled = true
        addChild(gameLayer)
    }
}
