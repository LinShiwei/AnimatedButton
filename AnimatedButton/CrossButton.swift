//
//  TickButton.swift
//  Hamburger Button
//
//  Created by Linsw on 16/6/1.
//  Copyright © 2016年 Robert Böhnke. All rights reserved.
//

import UIKit

class CrossButton: UIButton {

    var crossOne = CAShapeLayer()
    var crossTwo = CAShapeLayer()
    
    let crossPathOne: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 10, 10)
        CGPathAddLineToPoint(path, nil, 30, 30)
        return path
    }()
    let crossPathTwo: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 10, 30)
        CGPathAddLineToPoint(path, nil, 30, 10)
        return path
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.crossOne.path = crossPathOne
        self.crossTwo.path = crossPathTwo
        
        for layer in [ self.crossOne, self.crossTwo ] {
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
        
        self.crossOne.anchorPoint = CGPoint(x: 2.0 / 24.0, y: 2.0 / 24.0)
        self.crossOne.position = CGPoint(x: 10, y: 10)
        
        self.crossTwo.anchorPoint = CGPoint(x: 22.0 / 24.0, y: 2.0 / 24.0)
        self.crossTwo.position = CGPoint(x: 30, y: 10)
    }
    func setAnchorPoint(anchorPoint:CGPoint,forLayer layer:CALayer){
        let oldFrame = layer.frame
        layer.anchorPoint = anchorPoint
        layer.frame = oldFrame
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var change:Bool = false {
        //Subclass should override this property
        didSet{
            
        }
    }
}


extension CALayer {
    func ocb_applyAnimation(animation: CABasicAnimation) {
        let copy = animation.copy() as! CABasicAnimation
        
        if copy.fromValue == nil {
            copy.fromValue = self.presentationLayer()!.valueForKeyPath(copy.keyPath!)
        }
        
        self.addAnimation(copy, forKey: copy.keyPath)
        //由于这个动画的fillMode是Backwards所以addAnimation后，直接进入动画的初始状态，使得下面的setValue在视觉上并没有立即生效。下面的setValue反应的是最终的效果值
        self.setValue(copy.toValue, forKeyPath:copy.keyPath!)
    }
}
