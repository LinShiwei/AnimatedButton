//
//  PlayToPauseButton.swift
//  AnimatedButton
//
//  Created by Linsw on 16/6/2.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class PlayToPauseButton: UIButton {

    var layerOne = CAShapeLayer()
    var layerTwo = CAShapeLayer()
    var layerThree = CAShapeLayer()
    
    let lineOne: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 10, 20-11.547)
        CGPathAddLineToPoint(path, nil, 10, 20+11.547)
        return path
    }()
    let lineTwo: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 10, 20-11.547)
        CGPathAddLineToPoint(path, nil, 30, 20)
        return path
    }()
    let lineThree: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 10, 20+11.547)
        CGPathAddLineToPoint(path, nil, 30, 20)
        return path
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layerOne.path = lineOne
        self.layerTwo.path = lineTwo
        self.layerThree.path = lineThree
        
        for layer in [ self.layerOne, self.layerTwo, self.layerThree ] {
            layer.fillColor = nil
            layer.strokeColor = UIColor.blackColor().CGColor
            layer.lineWidth = 4
            layer.miterLimit = 4
            layer.lineCap = kCALineCapRound
            layer.masksToBounds = true
            
            let strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, .Round, .Miter, 4)
            
            layer.bounds = CGPathGetPathBoundingBox(strokingPath)
            print(layer.bounds)
            layer.actions = [
                "strokeStart": NSNull(),
                "strokeEnd": NSNull(),
                "transform": NSNull()
            ]
            
            self.layer.addSublayer(layer)
        }
        
        self.layerOne.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.layerOne.position = CGPoint(x: 10, y: 20)
        
        self.layerTwo.anchorPoint = CGPoint(x: 22.0 / 24.0, y: (2.0+11.547) / (2.0+2.0+11.547))
        self.layerTwo.position = CGPoint(x: 30, y: 20)
        
        self.layerThree.anchorPoint = CGPoint(x: 22.0 / 24.0, y: 2.0 / (2.0+2.0+11.547))
        self.layerThree.position = CGPoint(x: 30, y: 20)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var change:Bool = false {
        didSet{
            let transformTwo = CABasicAnimation(keyPath: "transform")
            transformTwo.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, -0.8, 0.5, 1.85)
            transformTwo.duration = 0.4
            transformTwo.fillMode = kCAFillModeBackwards
            
            let transformThree = transformTwo.copy() as! CABasicAnimation
            
            let rotateAngle = CGFloat(M_PI/3.0)

            
            if change {
                let translation = CATransform3DMakeTranslation(-4, 0, 0)
                transformTwo.toValue = NSValue(CATransform3D:CATransform3DRotate(translation, rotateAngle, 0, 0, 1))
                transformTwo.beginTime = CACurrentMediaTime()
                
                transformThree.toValue = NSValue(CATransform3D:CATransform3DRotate(translation, -rotateAngle, 0, 0, 1))
                transformThree.beginTime = CACurrentMediaTime()
            }else{
                transformTwo.toValue = NSValue(CATransform3D:CATransform3DIdentity)
                transformTwo.beginTime = CACurrentMediaTime()
                
                transformThree.toValue = NSValue(CATransform3D:CATransform3DIdentity)
                transformThree.beginTime = CACurrentMediaTime()
            }
        }
    }

}
