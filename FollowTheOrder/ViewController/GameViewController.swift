//
//  GameViewController.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 11.01.2022.
//

import UIKit
import SpriteKit
import GameplayKit

final class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = SKView(frame: view.bounds)
        guard let view = self.view as! SKView? else { return }
        
        let scene = MenuScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
        view.showsPhysics = false
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
