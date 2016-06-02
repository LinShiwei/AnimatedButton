//
//  TickButton.swift
//  Hamburger Button
//
//  Created by Linsw on 16/6/1.
//  Copyright © 2016年 Robert Böhnke. All rights reserved.
//

import UIKit

class TickButton: CrossButton {

    override var change:Bool {
        didSet{
            let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            strokeEnd.duration = 0.6
            strokeEnd.timingFunction = CAMediaTimingFunction(controlPoints: 0.1, 0, 0.4, 1)
            strokeEnd.fillMode = kCAFillModeBackwards

            let transformOne = CABasicAnimation(keyPath: "transform")
            transformOne.duration = 0.4
            transformOne.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, -0.8, 0.5, 1.85)
            transformOne.fillMode = kCAFillModeBackwards
            
            let transformTwo = transformOne.copy() as! CABasicAnimation
            
            if change {
                strokeEnd.toValue = 0.5
                strokeEnd.beginTime = CACurrentMediaTime()

                transformOne.toValue = NSValue(CATransform3D:CATransform3DMakeTranslation(-5, 10, 0))
                transformOne.beginTime = CACurrentMediaTime()+0.2

                transformTwo.toValue = NSValue(CATransform3D:CATransform3DMakeTranslation(5, 0, 0))
                transformTwo.beginTime = CACurrentMediaTime()+0.2
                
            }else{
                strokeEnd.toValue = 1.0
                strokeEnd.beginTime = CACurrentMediaTime()+0.2

                transformOne.toValue = NSValue(CATransform3D:CATransform3DIdentity)
                transformOne.beginTime = CACurrentMediaTime()
                
                transformTwo.toValue = NSValue(CATransform3D:CATransform3DIdentity)
                transformTwo.beginTime = CACurrentMediaTime()
            }
            self.crossOne.ocb_applyAnimation(transformOne)
            self.crossOne.ocb_applyAnimation(strokeEnd)
            self.crossTwo.ocb_applyAnimation(transformTwo)
        }
    }
}
