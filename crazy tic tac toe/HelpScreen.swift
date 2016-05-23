//
//  HelpScreen.swift
//  crazy tic tac toe
//
//  Created by Dorsa Norouzi on 5/23/16.
//  Copyright © 2016 Dorsa Norouzi, Ana Costa. All rights reserved.
//

import SpriteKit
import UIKit

class HelpScreen: SKScene {
    var tutorialLabel = UILabel(frame: CGRectMake(0, 0, 400, 40))
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.blackColor()
        tutorialLabel.textColor = UIColor.whiteColor()
        tutorialLabel.text = "In this tic tac toe game you can have one of each shape per spot, there are many ways to win:" + "\n" + "1- make a line, column or diagonal of the same shape." + "\n" + "2- make a line,column or diagonal of increasing(triangle-square-circle) or decreasing(circle-square-triangle) order. Notice that square-circle-triangle or triangle-circle-square doesn't count." + "\n" + "3- have a square, a circle and a triangle in the same spot."
        tutorialLabel.numberOfLines = 0
        tutorialLabel.font = UIFont(name: "Chalkduster", size: 18 )
        tutorialLabel.sizeToFit()
        tutorialLabel.textAlignment = NSTextAlignment.Center
        tutorialLabel.center = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.view!.addSubview(tutorialLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        tutorialLabel.removeFromSuperview()
        let scene = GameScene()
        let skView = self.view
        skView!.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        scene.size = (size: skView!.bounds.size)
        skView!.presentScene(scene)
}
}