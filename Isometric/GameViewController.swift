//
//  GameViewController.swift
//  Isometric
//
//  Created by Sukum Duangpattra  on 13/6/2562 BE.
//  Copyright © 2562 Sukum Duangpattra . All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        let skview = view as! SKView
        
        skview.showsNodeCount = true
        skview.showsFPS = true
        skview.ignoresSiblingOrder = true
        
        skview.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
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
