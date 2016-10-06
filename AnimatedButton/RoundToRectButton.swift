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
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 10, y: 14.77277))
        path.addLine(to: CGPoint(x: 10, y: 30))
        path.addLine(to: CGPoint(x: 30, y: 30))
        path.addLine(to: CGPoint(x: 30, y: 10))
        path.addLine(to: CGPoint(x: 10, y: 10))
        path.addLine(to: CGPoint(x: 10, y: 14.77277))
        
        path.addArc(tangent1End: CGPoint(x:20-12.73239 ,y: 20), tangent2End: CGPoint(x: 10,y: 30-4.77277), radius: radius)
        path.addArc(tangent1End: CGPoint(x:20 ,y: 20+24.35782), tangent2End: CGPoint(x: 30,y: 30-4.77277), radius: radius)
        path.addArc(tangent1End: CGPoint(x:20+12.73239 ,y: 20), tangent2End: CGPoint(x: 30,y: 10+4.77277), radius: radius)
        path.addArc(tangent1End: CGPoint(x:20 ,y: 20-24.35782), tangent2End: CGPoint(x: 10,y: 14.77277), radius: radius)

        
        return path
    }()
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.shapeLayer.path = shapePath
        
        for layer in [ self.shapeLayer] {
            layer.fillColor = nil
            layer.strokeColor = UIColor.black.cgColor
            layer.lineWidth = 4
            layer.miterLimit = 4
            layer.lineCap = kCALineCapRound
            layer.masksToBounds = true
            
            let strokingPath = CGPath(__byStroking: layer.path!, transform: nil, lineWidth: 4, lineCap: .round, lineJoin: .miter, miterLimit: 4)
            
            layer.bounds = (strokingPath?.boundingBoxOfPath)!
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
