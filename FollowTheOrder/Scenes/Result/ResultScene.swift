//
//  ResultScene.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 11.01.2022.
//

import SpriteKit
import UIKit

final class ResultScene: SKScene {
    
    private var result: GameResult
    private var actionButton = SKSpriteNode()
    private var viewModel: ResultViewModel
    
    private let sparkEmitter = SKEmitterNode(fileNamed: "Winning")
    private let resultLabel = SKLabelNode(fontNamed: "AmericanTypewriter")
    private let commentLabel = SKLabelNode(fontNamed: "AmericanTypewriter")
    private let resultLayer = SKNode()
    
    // MARK: - init
    init(size: CGSize,
         viewModel: ResultViewModel,
         result: GameResult) {
        self.viewModel = viewModel
        self.result = result
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        loadGameOverScene(result: result)
        viewModel.fetchWishes(result: result)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if viewModel.wishes != nil || commentLabel.text == nil {
            guard let wishes = viewModel.wishes else { return }
            commentLabel.text = wishes
            viewModel.setupFontSize(wishes: wishes, node: commentLabel)
        }
    }
    
    // MARK: - touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let transition: SKTransition = SKTransition.fade(withDuration: 1)
        let pos = touch.location(in: self)
        let node = self.atPoint(pos)
        if node.name == "sparkEmitter" {
            sparkEmitter?.removeFromParent()
        }
        
        guard node == actionButton else { return }
        guard view != nil else { return }
        switch result {
        case .win:
            if viewModel.level > UserDefaults.standard.integer(forKey: "bestResult") {
                UserDefaults.standard.set(viewModel.level, forKey: "bestResult")
            }
            UserDefaults.standard.set(1, forKey: "level")
            let scene: SKScene = MenuScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
            
        case .gameOver:
            UserDefaults.standard.set(1, forKey: "level")
            let scene: SKScene = MenuScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
            
        case .nextLevel:
            UserDefaults.standard.set(viewModel.level + 1, forKey: "level")
            
            if viewModel.level > UserDefaults.standard.integer(forKey: "bestResult") {
                UserDefaults.standard.set(viewModel.level, forKey: "bestResult")
            }
            let scene: SKScene = GameScene(size: self.size, viewModel: GameViewModel())
            self.view?.presentScene(scene, transition: transition)
            
        }
        
        
    }
    
    deinit {
        print("Deallocating \(self)")
    }
    
    
    // MARK: - Private methods for setup scene
    
    private func loadGameOverScene(result: GameResult) {
        setupBackground()
        setupMask()
        setupResultLayer()
        setupResultLabel(title: result.resultString)
        setupCommentLabel(title: result.commentLabel)
        setupActionButton(buttonName: result.buttonImageName)
        
        if case .win = result {
            setupSpark()
        }
    }
    
    private func setupBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: frame.size.width / 2,
                                      y: frame.size.height / 2)
        background.zPosition = -1
        addChild(background)
    }
    
    private func setupMask() {
        let mask = SKSpriteNode(color: .black,
                                size: CGSize(width: self.size.width,
                                             height: self.size.height))
        mask.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        mask.alpha = 0.2
        mask.zPosition = 0
        addChild(mask)
    }
    
    private func setupResultLayer() {
        resultLayer.alpha = 1
        resultLayer.zPosition = 2
        resultLayer.inputView?.tintColor = .black
        addChild(resultLayer)
    }
    
    private func setupResultLabel(title: String?) {
        resultLabel.fontColor = .white
        resultLabel.fontSize = 30
        resultLabel.numberOfLines = 0
        resultLabel.position = CGPoint(x: frame.size.width / 2,
                                       y: frame.size.height - 80  )
        resultLabel.zPosition = 2
        resultLabel.horizontalAlignmentMode = .center
        resultLabel.verticalAlignmentMode = .center
        resultLabel.text = result.resultString
        resultLayer.addChild(resultLabel)
    }
    
    private func setupCommentLabel(title: String?) {
        commentLabel.fontColor = .white
        commentLabel.fontSize = 20
        commentLabel.position = CGPoint(x: self.size.width / 2,
                                        y: self.size.height / 3 )
        commentLabel.zPosition = 2
        commentLabel.numberOfLines = 0
        commentLabel.preferredMaxLayoutWidth = frame.size.width * 0.9
        commentLabel.horizontalAlignmentMode = .center
        commentLabel.text = title
        resultLayer.addChild(commentLabel)
    }
    
    private func setupActionButton(buttonName: String) {
        actionButton = SKSpriteNode(imageNamed: buttonName)
        actionButton.size = CGSize(width: 100, height: 100)
        actionButton.position = CGPoint(x: frame.size.width / 2,
                                        y: frame.size.height / 4.5)
        actionButton.zPosition = 2
        resultLayer.addChild(actionButton)
    }
    
    private func setupSpark() {
        guard let spark = sparkEmitter else { return }
        spark.zPosition = 3
        spark.position = CGPoint(x: frame.size.width / 2,
                                 y: frame.size.height - 80  )
        spark.name = "sparkEmitter"
        resultLayer.addChild(spark)
    }
}
