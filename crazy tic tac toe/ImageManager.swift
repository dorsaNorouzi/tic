//
//  ImageManager.swift
//  crazy tic tac toe
//
//  Created by Dorsa Norouzi on 5/20/16.
//  Copyright © 2016 Dorsa Norouzi, Ana Costa. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    class func circleImage(rect: CGRect, ballColor: UIColor) -> UIImage {
        let size: CGSize = CGSize(width: rect.width, height: rect.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: rect)
        ballColor.setStroke()
        ovalPath.lineWidth = 2
        ovalPath.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //clear
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    class func squareImage(rect: CGRect, ballColor: UIColor) -> UIImage {
        let size: CGSize = CGSize(width: (rect.width * 2) / sqrt(2), height: (rect.height * 2)/sqrt(2))
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(4, 4, ((rect.width * 2) / sqrt(2)) - 8, ((rect.height * 2) / sqrt(2)) - 8))
        ballColor.setStroke()
        rectanglePath.lineWidth = 4
        rectanglePath.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //clear
        UIGraphicsEndImageContext()
        return image
        
    }
    
    class func triangleImage(rect: CGRect, ballColor: UIColor) -> UIImage {
        let sqrect = CGRectMake(4, 4, ((rect.width * 2) / sqrt(2)) - 8, ((rect.height * 2) / sqrt(2)) - 8)
        let size: CGSize = CGSize(width: (rect.width * 2) / sqrt(2), height: (rect.height * 2)/sqrt(2))
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(4, 4))
        bezierPath.addLineToPoint(CGPointMake(sqrect.width + 4, 4))
        bezierPath.addLineToPoint(CGPointMake((sqrect.width + 8) / 2  , sqrect.height ))
        bezierPath.addLineToPoint(CGPointMake(4, 4))
        bezierPath.closePath()
        ballColor.setStroke()
        bezierPath.lineWidth = 4
        bezierPath.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //clear
        UIGraphicsEndImageContext()
        return image
        
    }

    
}