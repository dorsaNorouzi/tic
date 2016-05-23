//
//  Shape.swift
//  crazy tic tac toe
//
//  Created by Dorsa Norouzi on 5/20/16.
//  Copyright © 2016 Dorsa Norouzi, Ana Costa. All rights reserved.
//
import Foundation
import SpriteKit

//circle = 1, square = 2, triangle = 3

class Shape: SKSpriteNode {
    public var type: Int
    public var shapeColor: UIColor
    init(type: Int, shapeC: UIColor, rect: CGRect ){
        self.type = type
        self.shapeColor = shapeC
        let image: UIImage?//do your setup here to make a UIImage
       
        switch type{
        case 1:
           image = ImageManager.circleImage(rect, ballColor: shapeC) //do your setup here to make a UIImage
            
        case 2:
           image = ImageManager.squareImage(rect, ballColor: shapeC) //do your setup here to make a UIImage
        case 3:
            image = ImageManager.triangleImage(rect, ballColor: shapeC) //do your setup here to make a UIImage
        default:
            image = ImageManager.squareImage(rect, ballColor: shapeC) //do your setup here to make a UIImage
        }
        
        let Texture = SKTexture(image: image!)
        
        super.init(texture: Texture, color: UIColor.blackColor(), size: image!.size)
        //self.xScale = 4
        //self.yScale = 4
        //truck should be 2
        //background should be 5
        //shapes can be 4
        
        if type == 1 {
            self.xScale = 2
            self.yScale = 2
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
