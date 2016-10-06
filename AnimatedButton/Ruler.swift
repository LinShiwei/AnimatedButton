//
//  Ruler.swift
//  AnimatedButton
//
//  Created by Linsw on 16/6/1.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit
let windowBounds = UIScreen.main.bounds

class Ruler: UIView {
    
    let verticalPaths:CGPath = {
        let path = CGMutablePath()
        
        for var row in 0..<Int(windowBounds.height*2){
            path.move(to: CGPoint(x: 0, y: CGFloat(row)))
//            CGPathMoveToPoint(path, nil, 0, CGFloat(row))
            path.addLine(to: CGPoint(x: windowBounds.width*2, y: CGFloat(row)))
//            CGPathAddLineToPoint(path, nil, windowBounds.width*2, CGFloat(row))
            row += 5
        }
        
        return path
    }()
    let horizonalPaths:CGPath = {
        let path = CGMutablePath()
        for var column in 0..<Int(windowBounds.width*2){
            path.move(to: CGPoint(x: CGFloat(column), y: 0))
//            CGPathMoveToPoint(path, nil, CGFloat(column), 0)
            path.addLine(to: CGPoint(x: CGFloat(column), y: windowBounds.height/2))
//            CGPathAddLineToPoint(path, nil, CGFloat(column), windowBounds.height*2)
            column += 5
        }
        
        return path
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let verticalLayer = CAShapeLayer()
        let horizonalLayer = CAShapeLayer()
        
        verticalLayer.path = verticalPaths
        horizonalLayer.path = horizonalPaths
        
        for layer in [ verticalLayer , horizonalLayer] {
            layer.fillColor = nil
            layer.strokeColor = UIColor.gray.cgColor
            layer.lineWidth = 1
            layer.miterLimit = 1
            layer.masksToBounds = true
            let strokingPath = CGPath(__byStroking: layer.path!, transform: nil, lineWidth: 1, lineCap: .round, lineJoin: .miter, miterLimit: 1)
            
            layer.bounds = (strokingPath?.boundingBoxOfPath)!

            self.layer.addSublayer(layer)
        }
        

    }
    

}
