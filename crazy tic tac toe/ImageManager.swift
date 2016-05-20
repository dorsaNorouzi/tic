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
    class func circleImage() -> UIImage {
        let size: CGSize = CGSize(width: 83, height: 70)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    
        //// Color Declarations
        let ballColor = UIColor(red: 0.934, green: 0.019, blue: 0.019, alpha: 1.000)
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(7, 6, 69, 58))
        ballColor.setStroke()
        ovalPath.lineWidth = 4
        ovalPath.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //clear
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    class func squareImage() -> UIImage {
        let size: CGSize = CGSize(width: 83, height: 70)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        //// Color Declarations
        let ballColor = UIColor(red: 0.934, green: 0.019, blue: 0.019, alpha: 1.000)
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(7, 6, 69, 58))
        ballColor.setStroke()
        ovalPath.lineWidth = 4
        ovalPath.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //clear
        UIGraphicsEndImageContext()
        return image
        
    }
    
    class func triangleImage() -> UIImage {
        let size: CGSize = CGSize(width: 83, height: 80)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        //// Color Declarations
        let ballColor = UIColor(red: 0.934, green: 0.019, blue: 0.019, alpha: 1.000)
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 69, 58))
        ballColor.setStroke()
        ovalPath.lineWidth = 4
        ovalPath.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //clear
        UIGraphicsEndImageContext()
        return image
        
    }

    
}