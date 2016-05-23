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
    var selected: Shape?
    var redTurn = true
    var arr = [[[Bool]]]()
    var arr2 = [[[Bool]]]()
    var help = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor.blackColor()
        
        //putting zeros in the array
        for var i = 0; i < 3; i = i + 1 {
            var a = [[Bool]]()
            for var j = 0; j < 3; j = j + 1 {
                var b = [Bool]()
                for var k = 0; k < 3; k = k + 1 {
                    b.append(false)
                }
                a.append(b)
            }
            arr.append(a)
        }
        
        //putting zeros in the array2
        for var i = 0; i < 3; i = i + 1 {
            var a = [[Bool]]()
            for var j = 0; j < 3; j = j + 1 {
                var b = [Bool]()
                for var k = 0; k < 3; k = k + 1 {
                    b.append(false)
                }
                a.append(b)
            }
            arr2.append(a)
        }
        
        //help sign
        help = SKSpriteNode(texture: SKTexture(image: ImageManager.imageForHelpSymbol()))
        help.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        help.name = "help"
        self.addChild(help)

        
        //left side stuff
        for var i = 0; i < 3; i = i + 1 {
            var shape = Shape(type: 1, shapeC: UIColor.redColor(), rect: getCircle())
            shape.position = CGPointMake(getCircle().width, CGRectGetMaxY(self.frame) - getCircle().width - 10)
            self.addChild(shape)
        }
        
        
        for var i = 0; i < 3; i = i + 1 {
            var shape2 = Shape(type: 2, shapeC: UIColor.redColor(), rect: getCircle())
            shape2.position = CGPointMake(getCircle().width, CGRectGetMidY(self.frame))
            self.addChild(shape2)
        }
        
        for var i = 0; i < 3; i = i + 1 {
            var shape3 = Shape(type: 3, shapeC: UIColor.redColor(), rect: getCircle())
            shape3.position = CGPointMake(getCircle().width, getCircle().width + 10)
            self.addChild(shape3)
            
        }
        
        //right side stuff
        for var i = 0; i < 3; i = i + 1 {
            var shape = Shape(type: 1, shapeC: UIColor.greenColor(), rect: getCircle())
            shape.position = CGPointMake(CGRectGetMaxX(self.frame) - getCircle().width, CGRectGetMaxY(self.frame) - getCircle().width - 10)
            self.addChild(shape)
        }
        
        
        for var i = 0; i < 3; i = i + 1 {
            var shape2 = Shape(type: 2, shapeC: UIColor.greenColor(), rect: getCircle())
            shape2.position = CGPointMake(CGRectGetMaxX(self.frame) - getCircle().width, CGRectGetMidY(self.frame))
            self.addChild(shape2)
        }
        
        for var i = 0; i < 3; i = i + 1 {
            var shape3 = Shape(type: 3, shapeC: UIColor.greenColor(), rect: getCircle())
            shape3.position = CGPointMake(CGRectGetMaxX(self.frame) - getCircle().width, getCircle().width + 10)
            self.addChild(shape3)
            
        }
        
        
        self.view?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(detectPan)))
        drawBG()
    }
    
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translationInView(self.view!)
        if let s = selected{
            selected!.position = CGPointMake(lastLocation.x + translation.x, lastLocation.y - translation.y)
        }
        if recognizer.state == UIGestureRecognizerState.Ended{
            toucheEnded()
        }
        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        //Shape(shapeName: "Square")
        
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        let nodes = self.nodesAtPoint(touchLocation)
        var touchingSomething = false
        for node in nodes {
            if let n = node as? Shape{
                if (redTurn && n.shapeColor == UIColor.redColor()) || (!redTurn && n.shapeColor == UIColor.greenColor()){
                    if n.position == CGPointMake(getCircle().width, CGRectGetMaxY(self.frame) - getCircle().width - 10) ||
                    n.position == CGPointMake(getCircle().width, CGRectGetMidY(self.frame)) ||
                    n.position == CGPointMake(getCircle().width, getCircle().width + 10) ||
                    n.position == CGPointMake(CGRectGetMaxX(self.frame) - getCircle().width, CGRectGetMaxY(self.frame) - getCircle().width - 10) ||
                    n.position == CGPointMake(CGRectGetMaxX(self.frame) - getCircle().width, CGRectGetMidY(self.frame)) ||
                        n.position == CGPointMake(CGRectGetMaxX(self.frame) - getCircle().width, getCircle().width + 10) {
                    selected = n
                    touchingSomething = true
                    }
                }
            }
            if node.name == "help" {
                let scene = HelpScreen()
                let skView = self.view!
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = (size: skView.bounds.size)
                skView.presentScene(scene)
            }
        }
        if !touchingSomething{
            selected = nil
        }
        
        // Remember original location
        if let s = selected{
            lastLocation = selected!.position
            //selectNodeForTouch(positionInScene)
        }
        for touch in touches {
            _ = touch.locationInNode(self)
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        let biggestSquare = UIScreen.mainScreen().bounds.height
        let margin = (UIScreen.mainScreen().bounds.width - biggestSquare)/2
        
        //get the size of the device
        let x = biggestSquare / 3
        let y = biggestSquare / 3
        
        // if (UIGestureRecognizer.state == UIGestureRecognizer)
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
        s1.strokeColor = UIColor.whiteColor()
        addChild(s1)
        
        let p2 = CGPathCreateMutable()
        CGPathMoveToPoint(p2, nil, 2 * x + margin , 0)
        
        CGPathAddLineToPoint(p2, nil,2 * x + margin, y * 3)
        
        
        let s2 = SKShapeNode()
        s2.path = p2
        s2.lineWidth = 15
        s2.strokeColor = UIColor.whiteColor()
        addChild(s2)
        
        let p3 = CGPathCreateMutable()
        CGPathMoveToPoint(p3, nil, margin, y)
        
        CGPathAddLineToPoint(p3, nil, x * 3 + margin, y)
        
        
        let s3 = SKShapeNode()
        s3.path = p3
        s3.lineWidth = 15
        s3.strokeColor = UIColor.whiteColor()
        addChild(s3)
        
        let p4 = CGPathCreateMutable()
        CGPathMoveToPoint(p4, nil, margin, 2 * y)
        
        CGPathAddLineToPoint(p4, nil, x * 3 + margin, 2 * y)
        
        
        let s4 = SKShapeNode()
        s4.path = p4
        s4.lineWidth = 15
        s4.strokeColor = UIColor.whiteColor()
        addChild(s4)
        
        
    }
    
    func getCircle() -> CGRect {
        let radius = UIScreen.mainScreen().bounds.height / 6 - 10
        let r = CGRectMake(0, 0, radius, radius)
        return r
        
    }
    
    
    
    func toucheEnded() {
        
        let biggestSquare = UIScreen.mainScreen().bounds.height
        let margin = (UIScreen.mainScreen().bounds.width - biggestSquare)/2
        
        //get the size of the device
        let x = biggestSquare / 3
        let y = biggestSquare / 3
        
        if redTurn {
            //first row squares
            if(selected?.position.x < margin + x && selected?.position.y > 2 * y ){
                switch selected!.type {
                case 1:
                    if !arr[0][0][0] && !arr2[0][0][0] {
                        arr[0][0][0] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                        
                    }
                case 2:
                    if !arr[0][0][1] && !arr2[0][0][1] {
                        arr[0][0][1] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                        
                    }
                case 3:
                    if !arr[0][0][2] && !arr2[0][0][2] {
                        arr[0][0][2] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                        
                    }
                default:
                    arr[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
            else if (selected?.position.x < 2 * x + margin && selected?.position.y > 2 * y) {
                switch selected!.type {
                case 1:
                    if !arr[0][1][0] && !arr2[0][1][0] {
                        arr[0][1][0] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                        
                    }
                case 2:
                    if !arr[0][1][1] && !arr2[0][1][1] {
                        arr[0][1][1] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                case 3:
                    if !arr[0][1][2] && !arr2[0][1][2] {
                        arr[0][1][2] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                default:
                    arr[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
            else if(selected?.position.x > 2 * x + margin && selected?.position.y > 2 * y) {
                
                switch selected!.type {
                case 1:
                    if !arr[0][2][0] && !arr2[0][2][0] {
                        arr[0][2][0] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                case 2:
                    if !arr[0][2][1] && !arr2[0][2][1] {
                        arr[0][2][1] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                case 3:
                    if !arr[0][2][2] && !arr2[0][2][2] {
                        arr[0][2][2] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                default:
                    arr[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
                
                //second row squares
            else if(selected?.position.x < x + margin && selected?.position.y > y) {
                
                switch selected!.type {
                case 1:
                    if !arr[1][0][0] && !arr2[1][0][0] {
                        arr[1][0][0] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                case 2:
                    if !arr[1][0][1] && !arr2[1][0][1] {
                        arr[1][0][1] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                case 3:
                    if !arr[1][0][2] && !arr2[1][0][2] {
                        arr[1][0][2] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                default:
                    arr[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
            else if (selected?.position.x < 2 * x + margin && selected?.position.y > y) {
                switch selected!.type {
                case 1:
                    if !arr[1][1][0] && !arr2[1][1][0] {
                        arr[1][1][0] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                        
                    }
                case 2:
                    if !arr[1][1][1] && !arr2[1][1][1] {
                        arr[1][1][1] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                        
                    }
                case 3:
                    if !arr[1][1][2] && !arr2[1][1][2] {
                        arr[1][1][2] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                        
                    }
                default:
                    arr[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
                
            }
            else if(selected?.position.x > 2 * x + margin && selected?.position.y > y) {
                
                switch selected!.type {
                case 1:
                    if !arr[1][2][0] && !arr2[1][2][0] {
                        arr[1][2][0] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                case 2:
                    if !arr[1][2][1] && !arr2[1][2][1] {
                        arr[1][2][1] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                case 3:
                    if !arr[1][2][2] && !arr2[1][2][2] {
                        arr[1][2][2] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                default:
                    arr[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
                
                //third row squares
            else if(selected?.position.x < margin + x && selected?.position.y > 0 ){
                
                switch selected!.type {
                case 1:
                    if !arr[2][0][0] && !arr2[2][0][0] {
                        arr[2][0][0] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, getCircle().width + 10)
                    }
                case 2:
                    if !arr[2][0][1] && !arr2[2][0][1] {
                        arr[2][0][1] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, getCircle().width + 10)
                    }
                case 3:
                    if !arr[2][0][2] && !arr2[2][0][2] {
                        arr[2][0][2] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, getCircle().width + 10)
                    }
                default:
                    arr[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
            else if (selected?.position.x < 2 * x + margin && selected?.position.y > 0) {
                switch selected!.type {
                case 1:
                    if !arr[2][1][0] && !arr2[2][1][0] {
                        arr[2][1][0] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, getCircle().width + 10)
                        
                    }
                case 2:
                    if !arr[2][1][1] && !arr2[2][1][1] {
                        arr[2][1][1] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, getCircle().width + 10)
                        
                    }
                case 3:
                    if !arr[2][1][2] && !arr2[2][1][2] {
                        arr[2][1][2] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, getCircle().width + 10)
                        
                    }
                default:
                    arr[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
                
                
            }
            else if(selected?.position.x > 2 * x + margin && selected?.position.y > 0) {
                
                switch selected!.type {
                case 1:
                    if !arr[2][2][0] && !arr2[2][2][0] {
                        arr[2][2][0] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, getCircle().width + 10)
                    }
                case 2:
                    if !arr[2][2][1] && !arr2[2][2][1] {
                        arr[2][2][1] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, getCircle().width + 10)
                    }
                case 3:
                    if !arr[2][2][2] && !arr2[2][2][2] {
                        arr[2][2][2] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, getCircle().width + 10)
                    }
                default:
                    arr[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
            if let s = selected{
                if  selected!.position != CGPointMake(margin + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10) &&
                    selected!.position != CGPointMake(margin + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10) &&
                    selected!.position != CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10) &&
                    selected!.position != CGPointMake(margin + getCircle().width + 10, CGRectGetMidY(self.frame)) &&
                    selected!.position != CGPointMake(margin + x + getCircle().width + 10, CGRectGetMidY(self.frame)) &&
                    selected!.position != CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMidY(self.frame)) &&
                    selected!.position != CGPointMake(margin + getCircle().width + 10, getCircle().width + 10) &&
                    selected!.position != CGPointMake(margin + x + getCircle().width + 10, getCircle().width + 10) &&
                    selected!.position != CGPointMake(margin + x + x + getCircle().width + 10, getCircle().width + 10) {
                    switch selected!.type {
                    case 1:
                        selected!.position = CGPointMake(getCircle().width, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    case 2:
                        selected!.position = CGPointMake(getCircle().width, CGRectGetMidY(self.frame))
                    case 3:
                        selected!.position = CGPointMake(getCircle().width, getCircle().width + 10)
                    default:
                        print(3)
                    }
                    redTurn = !redTurn
                }
            }
        } else {
            
            //green turn
            //first row squares
            if(selected?.position.x < margin + x && selected?.position.y > 2 * y ){
                
                switch selected!.type {
                case 1:
                    if !arr2[0][0][0] && !arr[0][0][0] {
                        arr2[0][0][0] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                case 2:
                    if !arr2[0][0][1] && !arr[0][0][1] {
                        arr2[0][0][1] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                case 3:
                    if !arr2[0][0][2] && !arr[0][0][2] {
                        arr2[0][0][2] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                default:
                    arr2[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
            else if (selected?.position.x < 2 * x + margin && selected?.position.y > 2 * y) {
                
                switch selected!.type {
                case 1:
                    if !arr2[0][1][0] && !arr[0][1][0] {
                        arr2[0][1][0] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                case 2:
                    if !arr2[0][1][1] && !arr[0][1][1] {
                        arr2[0][1][1] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                case 3:
                    if !arr2[0][1][2] && !arr[0][1][2] {
                        arr2[0][1][2] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                default:
                    if !arr2[0][0][0] && !arr[0][0][0] {
                        arr2[0][0][0] = false
                    }
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
            else if(selected?.position.x > 2 * x + margin && selected?.position.y > 2 * y) {
                
                switch selected!.type {
                case 1:
                    if !arr2[0][2][0] && !arr[0][2][0] {
                        arr2[0][2][0] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                case 2:
                    if !arr2[0][2][1] && !arr[0][2][1] {
                        arr2[0][2][1] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                case 3:
                    if !arr2[0][2][2] && !arr[0][2][2] {
                        arr2[0][2][2] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    }
                default:
                    arr2[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
                
                //second row squares
            else if(selected?.position.x < x + margin && selected?.position.y > y) {
                
                switch selected!.type {
                case 1:
                    if !arr2[1][0][0] && !arr[1][0][0] {
                        arr2[1][0][0] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                case 2:
                    if !arr2[1][0][1] && !arr[1][0][1] {
                        arr2[1][0][1] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                case 3:
                    if !arr2[1][0][2] && !arr[1][0][2] {
                        arr2[1][0][2] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                default:
                    arr2[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
            else if (selected?.position.x < 2 * x + margin && selected?.position.y > y) {
                
                switch selected!.type {
                case 1:
                    if !arr2[1][1][0] && !arr[1][1][0] {
                        arr2[1][1][0] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                case 2:
                    if !arr2[1][1][1] && !arr[1][1][1] {
                        arr2[1][1][1] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                case 3:
                    if !arr2[1][1][2] && !arr[1][1][2] {
                        arr2[1][1][2] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                default:
                    arr2[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
                
            }
            else if(selected?.position.x > 2 * x + margin && selected?.position.y > y) {
                
                switch selected!.type {
                case 1:
                    if !arr2[1][2][0] && !arr[1][2][0] {
                        arr2[1][2][0] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                case 2:
                    if !arr2[1][2][1] && !arr[1][2][1] {
                        arr2[1][2][1] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                case 3:
                    if !arr2[1][2][2] && !arr[1][2][2] {
                        arr2[1][2][2] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMidY(self.frame))
                    }
                default:
                    arr2[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
                
            //third row squares
            else if(selected?.position.x < margin + x && selected?.position.y > 0 ){
                
                switch selected!.type {
                case 1:
                    if !arr2[2][0][0] && !arr[2][0][0] {
                        arr2[2][0][0] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, getCircle().width + 10)
                    }
                case 2:
                    if !arr2[2][0][1] && !arr[2][0][1] {
                        arr2[2][0][1] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, getCircle().width + 10)
                    }
                case 3:
                    if !arr2[2][0][2] && !arr[2][0][2] {
                        arr2[2][0][2] = true
                        selected!.position = CGPointMake(margin + getCircle().width + 10, getCircle().width + 10)
                    }
                default:
                    arr2[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
            else if (selected?.position.x < 2 * x + margin && selected?.position.y > 0) {
                
                switch selected!.type {
                case 1:
                    if !arr2[2][1][0] && !arr[2][1][0] {
                        arr2[2][1][0] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, getCircle().width + 10)
                    }
                case 2:
                    if !arr2[2][1][1] && !arr[2][1][1] {
                        arr2[2][1][1] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, getCircle().width + 10)
                    }
                case 3:
                    if !arr2[2][1][2] && !arr[2][1][2] {
                        arr2[2][1][2] = true
                        selected!.position = CGPointMake(margin + x + getCircle().width + 10, getCircle().width + 10)
                    }
                default:
                    arr2[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
            else if(selected?.position.x > 2 * x + margin && selected?.position.y > 0) {
                
                switch selected!.type {
                case 1:
                    if !arr2[2][2][0] && !arr[2][2][0] {
                        arr2[2][2][0] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, getCircle().width + 10)
                    }
                case 2:
                    if !arr2[2][2][1] && !arr[2][2][1] {
                        arr2[2][2][1] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, getCircle().width + 10)
                    }
                case 3:
                    if !arr2[2][2][2] && !arr[2][2][2] {
                        arr2[2][2][2] = true
                        selected!.position = CGPointMake(margin + x + x + getCircle().width + 10, getCircle().width + 10)
                    }
                default:
                    arr2[0][0][0] = false
                }
                winTest(0, y: 0)
                redTurn = !redTurn
            }
            if let s = selected{
                if  selected!.position != CGPointMake(margin + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10) &&
                    selected!.position != CGPointMake(margin + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10) &&
                    selected!.position != CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMaxY(self.frame) - getCircle().width - 10) &&
                    selected!.position != CGPointMake(margin + getCircle().width + 10, CGRectGetMidY(self.frame)) &&
                    selected!.position != CGPointMake(margin + x + getCircle().width + 10, CGRectGetMidY(self.frame)) &&
                    selected!.position != CGPointMake(margin + x + x + getCircle().width + 10, CGRectGetMidY(self.frame)) &&
                    selected!.position != CGPointMake(margin + getCircle().width + 10, getCircle().width + 10) &&
                    selected!.position != CGPointMake(margin + x + getCircle().width + 10, getCircle().width + 10) &&
                    selected!.position != CGPointMake(margin + x + x + getCircle().width + 10, getCircle().width + 10) {
                    switch selected!.type {
                    case 1:
                        selected!.position = CGPointMake(CGRectGetMaxX(self.frame) - getCircle().width, CGRectGetMaxY(self.frame) - getCircle().width - 10)
                    case 2:
                        selected!.position = CGPointMake(CGRectGetMaxX(self.frame) - getCircle().width, CGRectGetMidY(self.frame))
                    case 3:
                        selected!.position = CGPointMake(CGRectGetMaxX(self.frame) - getCircle().width, getCircle().width + 10)                default:
                            print(3)
                    }
                    redTurn = !redTurn
                }
            }
            
        }
        
    }
    
    func winTest(x : Int, y : Int ) {
        var win = false
        var winBlue = false
        
        //red stuff
        //if they are equal
        for var i = 0; i < 3; i = i + 1 {
            if arr[0][0][i] && arr[0][1][i] && arr[0][2][i] {
                win = true
            } else if arr[1][0][i] && arr[1][1][i] && arr[1][2][i] {
                win = true
            } else if arr[2][0][i] && arr[2][1][i] &&  arr[2][2][i] {
                win = true
            } else if arr[0][0][i] && arr[1][0][i] &&  arr[2][0][i] {
                win = true
            } else if arr[0][1][i] && arr[1][1][i] &&  arr[2][1][i] {
                win = true
            } else if arr[0][2][i] && arr[1][2][i] &&  arr[2][2][i] {
                win = true
            } else if arr[0][0][i] && arr[1][0][i] && arr[2][2][i] {
                win = true
            } else if arr[0][2][i] && arr[1][1][i] && arr[2][0][i] {
                win = true
            } else if arr[0][0][i] && arr[1][0][i] && arr[2][0][i] {
                win = true
            } else if arr[0][0][i] && arr[1][1][i] && arr[2][2][i] {
                win = true
            }else if arr[0][2][i] && arr[1][1][i] && arr[2][0][i] {
                win = true
            }
            
        }
        
        //if they are in decreasing order
        
        if arr[0][0][0] && arr[0][1][1] &&  arr[0][2][2] {
            win = true
        } else if arr[1][0][0] && arr[1][1][1] && arr[1][2][2] {
            win = true
        } else if arr[2][0][0] && arr[2][1][1] && arr[2][2][2] {
            win = true
        } else if arr[0][0][0] && arr[1][0][1] && arr[2][0][2] {
            win = true
        } else if arr[0][1][0] && arr[1][1][1] && arr[2][1][2] {
            win = true
        } else if arr[0][2][0] && arr[1][2][1] && arr[2][2][2] {
            win = true
        } else if arr[0][0][0] && arr[1][0][1] && arr[2][2][2] {
            win = true
        } else if arr[0][2][0] && arr[1][1][1] && arr[2][0][2] {
            win = true
        } else if arr[0][0][0] && arr[1][0][1] && arr[2][0][2] {
            win = true
        } else if arr[0][0][0] && arr[1][1][1] && arr[2][2][2] {
            win = true
        } else if arr[0][2][0] && arr[1][1][1] && arr[2][0][2] {
            win = true
        }
        
        //if they are in increasing order
        
        if arr[0][0][2] && arr[0][1][1] &&  arr[0][2][0] {
            win = true
        } else if arr[1][0][2] && arr[1][1][1] && arr[1][2][0] {
            win = true
        } else if arr[2][0][2] && arr[2][1][1] && arr[2][2][0] {
            win = true
        } else if arr[0][0][2] && arr[1][0][1] && arr[2][0][0] {
            win = true
        } else if arr[0][1][2] && arr[1][1][1] && arr[2][1][0] {
            win = true
        } else if arr[0][2][2] && arr[1][2][1] && arr[2][2][0] {
            win = true
        } else if arr[0][0][2] && arr[1][0][1] && arr[2][2][0] {
            win = true
        } else if arr[0][2][2] && arr[1][1][1] && arr[2][0][0] {
            win = true
        } else if arr[0][0][2] && arr[1][0][1] && arr[2][0][0] {
            win = true
        } else if arr[0][0][2] && arr[1][1][1] && arr[2][2][0] {
            win = true
        } else if arr[0][2][2] && arr[1][1][1] && arr[2][0][0] {
            win = true
        }
        
        //if they are inside each other
        for var i = 0; i < 3; i = i + 1 {
            for var j = 0; j < 3; j = j + 1 {
                if arr[i][j][0] && arr[i][j][1] && arr[i][j][2] {
                    win = true
                }
            }
        }
        
        //green stuff
        //if they are equal
        for var i = 0; i < 3; i = i + 1 {
            if arr2[0][0][i] && arr2[0][1][i] && arr2[0][2][i] {
                winBlue = true
            } else if arr2[1][0][i] && arr2[1][1][i] && arr2[1][2][i] {
                winBlue = true
            } else if arr2[2][0][i] && arr2[2][1][i] &&  arr2[2][2][i] {
                winBlue = true
            } else if arr2[0][0][i] && arr2[1][0][i] &&  arr2[2][0][i] {
                winBlue = true
            } else if arr2[0][1][i] && arr2[1][1][i] &&  arr2[2][1][i] {
                winBlue = true
            } else if arr2[0][2][i] && arr2[1][2][i] &&  arr2[2][2][i] {
                winBlue = true
            } else if arr2[0][0][i] && arr2[1][0][i] && arr2[2][2][i] {
                winBlue = true
            } else if arr2[0][2][i] && arr2[1][1][i] && arr2[2][0][i] {
                winBlue = true
            } else if arr2[0][0][i] && arr2[1][0][i] && arr2[2][0][i] {
                winBlue = true
            } else if arr2[0][0][i] && arr2[1][1][i] && arr2[2][2][i] {
                winBlue = true
            }else if arr2[0][2][i] && arr2[1][1][i] && arr2[2][0][i] {
                winBlue = true
            }
        }
        
        //if they are in decreasing order
        
        if arr2[0][0][0] && arr2[0][1][1] &&  arr2[0][2][2] {
            winBlue = true
        } else if arr2[1][0][0] && arr2[1][1][1] && arr2[1][2][2] {
            winBlue = true
        } else if arr2[2][0][0] && arr2[2][1][1] && arr2[2][2][2] {
            winBlue = true
        } else if arr2[0][0][0] && arr2[1][0][1] && arr2[2][0][2] {
            winBlue = true
        } else if arr2[0][1][0] && arr2[1][1][1] && arr2[2][1][2] {
            winBlue = true
        } else if arr2[0][2][0] && arr2[1][2][1] && arr2[2][2][2] {
            winBlue = true
        } else if arr2[0][0][0] && arr2[1][0][1] && arr2[2][2][2] {
            winBlue = true
        } else if arr2[0][2][0] && arr2[1][1][1] && arr2[2][0][2] {
            winBlue = true
        } else if arr2[0][0][0] && arr2[1][0][1] && arr2[2][0][2] {
            winBlue = true
        } else if arr2[0][0][0] && arr2[1][1][1] && arr2[2][2][2] {
            winBlue = true
        } else if arr2[0][2][0] && arr2[1][1][1] && arr2[2][0][2] {
            winBlue = true
        }
        
        
        //if they are in increasing order
        
        if arr2[0][0][2] && arr2[0][1][1] &&  arr2[0][2][0] {
            winBlue = true
        } else if arr2[1][0][2] && arr2[1][1][1] && arr2[1][2][0] {
            winBlue = true
        } else if arr2[2][0][2] && arr2[2][1][1] && arr2[2][2][0] {
            winBlue = true
        } else if arr2[0][0][2] && arr2[1][0][1] && arr2[2][0][0] {
            winBlue = true
        } else if arr2[0][1][2] && arr2[1][1][1] && arr2[2][1][0] {
            winBlue = true
        } else if arr2[0][2][2] && arr2[1][2][1] && arr2[2][2][0] {
            winBlue = true
        } else if arr2[0][0][2] && arr2[1][0][1] && arr2[2][2][0] {
            winBlue = true
        } else if arr2[0][2][2] && arr2[1][1][1] && arr2[2][0][0] {
            winBlue = true
        } else if arr2[0][0][2] && arr2[1][0][1] && arr2[2][0][0] {
            winBlue = true
        } else if arr2[0][0][2] && arr2[1][1][1] && arr2[2][2][0] {
            winBlue = true
        } else if arr2[0][2][2] && arr2[1][1][1] && arr2[2][0][0] {
            winBlue = true
        }
        
        
        //if they are inside each other
        for var i = 0; i < 3; i = i + 1 {
            for var j = 0; j < 3; j = j + 1 {
                if arr2[i][j][0] && arr2[i][j][1] && arr2[i][j][2] {
                    winBlue = true
                }
            }
        }
        
        if win {
            won(0)
        }
        if winBlue {
            won(1)
        }
        
    }
    
    func won(who: Int) {
        let scene = WinScreen()
        let skView = self.view!
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        scene.size = (size: skView.bounds.size)
        if who == 0{
            scene.who = 0
        }else{
            scene.who = 1
        }
        skView.presentScene(scene)
    }
    
}