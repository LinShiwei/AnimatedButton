//
//  RoundToRectButton.swift
//  AnimatedButton
//
//  Created by Linsw on 16/6/2.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

let radius = CGFloat(20.0 / sqrt(M_PI))

class RoundToRectButton: UIButton {


    let strokeDivision = CGFloat(4*20/(4*20 + 2*M_PI*20.0 / sqrt(M_PI)))
    
    var shapeLayer = CAShapeLayer()

    let shapePath: CGPath = {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 10, 14.77277)
        CGPathAddLineToPoint(path, nil, 10, 30)
        CGPathAddLineToPoint(path, nil, 30, 30)
        CGPathAddLineToPoint(path, nil, 30, 10)
        CGPathAddLineToPoint(path, nil, 10, 10)
        CGPathAddLineToPoint(path, nil, 10, 14.77277)
        CGPathAddArcToPoint(path, nil, 20-12.73239, 20, 10, 30-4.77277, radius)
        CGPathAddArcToPoint(path, nil, 20, 20+24.35782, 30, 30-4.77277, radius)
        CGPathAddArcToPoint(path, nil, 20+12.73239, 20, 30, 10+4.77277, radius)
        CGPathAddArcToPoint(path, nil, 20, 20-24.35782, 10, 14.77277, radius)

        return path
    }()
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.shapeLayer.path = shapePath
        
        for layer in [ self.shapeLayer] {
            layer.fillColor = nil
            layer.strokeColor = UIColor.blackColor().CGColor
            layer.lineWidth = 4
            layer.miterLimit = 4
            layer.lineCap = kCALineCapRound
            layer.masksToBounds = true
            
            let strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, .Round, .Miter, 4)
            
            layer.bounds = CGPathGetPathBoundingBox(strokingPath)
            layer.actions = [
                "strokeStart": NSNull(),
                "strokeEnd": NSNull(),
                "transform": NSNull()
            ]
            
            self.layer.addSublayer(layer)
        }
        
        self.shapeLayer.position = CGPoint(x: 20, y: 20)
        self.shapeLayer.strokeStart = 0.0
        self.shapeLayer.strokeEnd = strokeDivision
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var change:Bool = false {
        didSet{
            let strokeStart = CABasicAnimation(keyPath: "strokeStart")
            let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")

            if change {
                strokeStart.toValue = strokeDivision
                strokeStart.duration = 0.5
                strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.25, 0, 0.8, 1)
                
                strokeEnd.toValue = 1.0
                strokeEnd.duration = 0.6
                strokeEnd.timingFunction = CAMediaTimingFunction(controlPoints: 0.25, -0.4, 0.8, 1)
            }else{
                strokeStart.toValue = 0
                strokeStart.duration = 0.5
                strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.25, 0, 0.8, 1)
                strokeStart.beginTime = CACurrentMediaTime() + 0.1
                strokeStart.fillMode = kCAFillModeBackwards

                strokeEnd.toValue = strokeDivision
                strokeEnd.duration = 0.6
                strokeEnd.timingFunction = CAMediaTimingFunction(controlPoints: 0.25, 0.3, 0.8, 0.9)
            }
            
            self.shapeLayer.ocb_applyAnimation(strokeStart)
            self.shapeLayer.ocb_applyAnimation(strokeEnd)
        }
    }
    }
