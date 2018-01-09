//
//  RCCloud.swift
//  Invasion
//
//  Created by Ryan Ching on 5/14/15.
//  Copyright (c) 2015 Ryan Ching. All rights reserved.
//

import Foundation
import SpriteKit

class RCStar: SKShapeNode {
    
    init(size: CGSize){
        super.init()
        let path = CGPath(ellipseIn: CGRect(x: 0,y: 0, width: size.width, height: size.height), transform: nil)
        self.path = path
        fillColor = UIColor.yellow
        /*
        let num = arc4random_uniform((UInt32)((100))) + 1
        let num2 = arc4random_uniform((UInt32)((100))) + 1
        let time: Double!
        if num > 50 {
        if( num > num2){
            time = Double(num2 / num)
        }
        else{
            time = Double(num / num2)
        }
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: Selector("runBlinkAnimation"), userInfo: nil, repeats: false)
        }
*/
        self.run(blinkAnimation())
        
        self.zPosition = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func runBlinkAnimation() {
        
    }
    
    func blinkAnimation() -> SKAction {
        let num = arc4random_uniform((UInt32)((10))) + 1
        let duration = Double(num)
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatForever(blink)
    }
    
    
}
