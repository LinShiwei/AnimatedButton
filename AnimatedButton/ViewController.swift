//
//  ViewController.swift
//  AnimatedButton
//
//  Created by Linsw on 16/6/1.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var xToVButton : XToVButton!
    var tickButton : TickButton!
    var playToPauseButton : PlayToPauseButton!
    var roundToRectButton : RoundToRectButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 38.0 / 255, green: 151.0 / 255, blue: 68.0 / 255, alpha: 1)
      
        self.xToVButton = XToVButton(frame: CGRect(x: 50, y: 200, width: 40, height: 40))
        self.xToVButton.addTarget(self, action: "xToV:", forControlEvents: .TouchUpInside)
        self.view.addSubview(xToVButton)
        
        self.tickButton = TickButton(frame: CGRect(x: 50, y: 250, width: 40, height: 40))
        self.tickButton.addTarget(self, action: "tick:", forControlEvents: .TouchUpInside)
        self.view.addSubview(tickButton)
        
        self.playToPauseButton = PlayToPauseButton(frame: CGRect(x: 50, y: 300, width: 40, height: 40))
        self.playToPauseButton.addTarget(self, action: "playToPause:", forControlEvents: .TouchUpInside)
        self.view.addSubview(playToPauseButton)
        
        self.roundToRectButton = RoundToRectButton(frame: CGRect(x: 50, y: 350, width: 40, height: 40))
        self.roundToRectButton.addTarget(self, action: "roundToRect:", forControlEvents: .TouchUpInside)
        self.view.addSubview(roundToRectButton)
        
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle  {
        return .LightContent
    }

    func xToV(sender:UIButton){
        self.xToVButton.change = !self.xToVButton.change
    }
    func tick(sender:UIButton){
        self.tickButton.change = !self.tickButton.change
    }
    func playToPause(sender:UIButton){
        self.playToPauseButton.change = !self.playToPauseButton.change
    }
    func roundToRect(sender:UIButton){
        self.roundToRectButton.change = !self.roundToRectButton.change
    }
}

