//
//  Ruler.swift
//  AnimatedButton
//
//  Created by Linsw on 16/6/1.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit
let windowBounds = UIScreen.mainScreen().bounds

class Ruler: UIView {
    
    let verticalPaths:CGPath = {
        let path = CGPathCreateMutable()
        for var row = 0;row < Int(windowBounds.height*2); row+=5{
            CGPathMoveToPoint(path, nil, 0, CGFloat(row))
            CGPathAddLineToPoint(path, nil, windowBounds.width*2, CGFloat(row))
        }
        
        return path
    }()
    let horizonalPaths:CGPath = {
        let path = CGPathCreateMutable()
        for var column = 0;column < Int(windowBounds.width*2); column+=5{
            CGPathMoveToPoint(path, nil, CGFloat(column), 0)
            CGPathAddLineToPoint(path, nil, CGFloat(column), windowBounds.height*2)
        }
        
        return path
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print(windowBounds)
        let verticalLayer = CAShapeLayer()
        let horizonalLayer = CAShapeLayer()
        
        verticalLayer.path = verticalPaths
        horizonalLayer.path = horizonalPaths
        
        for layer in [ verticalLayer , horizonalLayer] {
            layer.fillColor = nil
            layer.strokeColor = UIColor.purpleColor().CGColor
            layer.lineWidth = 1
            layer.miterLimit = 1
            layer.masksToBounds = true
            let strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 1, .Round, .Miter, 1)
            
            layer.bounds = CGPathGetPathBoundingBox(strokingPath)

            self.layer.addSublayer(layer)
        }
        

    }
    

}
