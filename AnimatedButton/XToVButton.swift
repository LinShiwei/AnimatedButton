//
//  XToVButton.swift
//  Hamburger Button
//
//  Created by Linsw on 16/5/31.
//  Copyright © 2016年 Robert Böhnke. All rights reserved.
//

import UIKit

class XToVButton: CrossButton {

    override var change:Bool {
        didSet{
            let transformOne = CABasicAnimation(keyPath: "transform")
            transformOne.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, -0.8, 0.5, 1.85)
            transformOne.duration = 0.4
            transformOne.fillMode = kCAFillModeBackwards
            
            let transformTwo = transformOne.copy() as! CABasicAnimation
            
            let rotateAngle = CGFloat(M_PI_4 - asin(sqrt(2)/4.0))
            assert(rotateAngle > 0)
            if change {
                transformOne.toValue = NSValue(caTransform3D:CATransform3DMakeRotation(rotateAngle, 0, 0, 1))
                transformOne.beginTime = CACurrentMediaTime()
                
                transformTwo.toValue = NSValue(caTransform3D:CATransform3DMakeRotation(-rotateAngle, 0, 0, 1))
                transformTwo.beginTime = CACurrentMediaTime()

            }else{
                transformOne.toValue = NSValue(caTransform3D:CATransform3DIdentity)
                transformOne.beginTime = CACurrentMediaTime()
                
                transformTwo.toValue = NSValue(caTransform3D:CATransform3DIdentity)
                transformTwo.beginTime = CACurrentMediaTime()
            }
            self.crossOne.ocb_applyAnimation(transformOne)
            self.crossTwo.ocb_applyAnimation(transformTwo)
        }
    }
}
