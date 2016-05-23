//
//  WinScreen.swift
//  crazy tic tac toe
//
//  Created by Dorsa Norouzi on 5/22/16.
//  Copyright © 2016 Dorsa Norouzi, Ana Costa. All rights reserved.
//

import SpriteKit
import UIKit

class WinScreen: SKScene {
    let gameOverLabel = SKLabelNode(fontNamed:"Chalkduster")
    public var who = 0
    override func didMoveToView(view: SKView) {
        gameOverLabel.fontColor = UIColor.blueColor()
        if who == 0{
            gameOverLabel.fontColor = UIColor.redColor()
        }
        self.backgroundColor = UIColor.blackColor()
        gameOverLabel.text = "You Won"
        gameOverLabel.fontSize = 50
        gameOverLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) )
        self.addChild(gameOverLabel)
    }
}