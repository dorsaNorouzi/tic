//
//  GameScene.swift
//  crazy tic tac toe
//
//  Created by Dorsa Norouzi on 5/20/16.
//  Copyright (c) 2016 Dorsa Norouzi, Ana Costa. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene {
    var lastLocation:CGPoint = CGPointMake(0, 0)
    var shape: Shape?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor.whiteColor()
        shape = Shape(type: 1, shapeC: UIColor.redColor())
        shape!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(shape!)
        
        self.view?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(detectPan)))
        drawBG()
    }
    
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translationInView(self.view!)
        shape!.position = CGPointMake(lastLocation.x + translation.x, lastLocation.y - translation.y)
        print(3)
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        //Shape(shapeName: "Square")
        
        // Remember original location
        lastLocation = shape!.position
        //selectNodeForTouch(positionInScene)
        
        for touch in touches {
            _ = touch.locationInNode(self)
            
            
        }
    }


    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }

    func drawBG() {
        let biggestSquare = UIScreen.mainScreen().bounds.height
        let margin = (UIScreen.mainScreen().bounds.width - biggestSquare)/2
        
        //get the size of the device
        let x = biggestSquare / 3
        let y = biggestSquare / 3
        
        //creating a CGPAth
        let p = CGPathCreateMutable()
        CGPathMoveToPoint(p, nil, margin + x, 0)
        
        //adding line
        CGPathAddLineToPoint(p, nil, margin + x, y * 3)
        
        //drawing the line by making it a node
        let s1 = SKShapeNode()
        s1.path = p
        s1.lineWidth = 15
        s1.strokeColor = UIColor.blackColor()
        addChild(s1)
        
        let p2 = CGPathCreateMutable()
        CGPathMoveToPoint(p2, nil, 2 * x + margin , 0)
        
        CGPathAddLineToPoint(p2, nil,2 * x + margin, y * 3)
        
        
        let s2 = SKShapeNode()
        s2.path = p2
        s2.lineWidth = 15
        s2.strokeColor = UIColor.blackColor()
        addChild(s2)
        
        let p3 = CGPathCreateMutable()
        CGPathMoveToPoint(p3, nil, margin, y)
        
        CGPathAddLineToPoint(p3, nil, x * 3 + margin, y)
        
        
        let s3 = SKShapeNode()
        s3.path = p3
        s3.lineWidth = 15
        s3.strokeColor = UIColor.blackColor()
        addChild(s3)
        
        let p4 = CGPathCreateMutable()
        CGPathMoveToPoint(p4, nil, margin, 2 * y)
        
        CGPathAddLineToPoint(p4, nil, x * 3 + margin, 2 * y)
        
        
        let s4 = SKShapeNode()
        s4.path = p4
        s4.lineWidth = 15
        s4.strokeColor = UIColor.blackColor()
        addChild(s4)
        
        

    }


}