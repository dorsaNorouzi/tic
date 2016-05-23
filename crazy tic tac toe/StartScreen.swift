//
//  StartScreen.swift
//  crazy tic tac toe
//
//  Created by Dorsa Norouzi on 5/23/16.
//  Copyright © 2016 Dorsa Norouzi, Ana Costa. All rights reserved.
//

import SpriteKit
import UIKit

class StartScreen: SKScene {
    let startLabel = SKLabelNode(fontNamed:"Chalkduster")
    
    override func didMoveToView(view: SKView) {
        startLabel.fontColor = UIColor.whiteColor()
        self.backgroundColor = UIColor.blackColor()
        startLabel.text = "Touch to start"
        startLabel.fontSize = 50
        startLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) )
        self.addChild(startLabel)
        
        //help sign
        var help = SKSpriteNode(texture: SKTexture(image: ImageManager.imageForHelpSymbol()))
        help.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 70)
        help.name = "help"
        help.xScale = 2
        help.yScale = 2
        self.addChild(help)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        let nodes = self.nodesAtPoint(touchLocation)
        var help = false
        for node in nodes {
            if node.name == "help" {
                help = true
                let scene = HelpScreen()
                let skView = self.view!
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = (size: skView.bounds.size)
                skView.presentScene(scene)
            }
        }
        
        if !help {
            let scene = GameScene()
            let skView = self.view
            skView!.ignoresSiblingOrder = true
            scene.scaleMode = .ResizeFill
            scene.size = (size: skView!.bounds.size)
            skView!.presentScene(scene)
        }
        
    }
}
