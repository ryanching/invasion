//
//  RCBulletGenerator.swift
//  Invasion
//
//  Created by Ryan Ching on 5/10/15.
//  Copyright (c) 2015 Ryan Ching. All rights reserved.
//

import Foundation
import SpriteKit

class RCBulletGenerator: SKSpriteNode {
    
    
    
    func fireBullet(_ touchLocation: CGPoint) {
        let bullet = RCBullet()
        bullet.position = CGPoint(x: -250, y: 0)
        bullet.isHidden = true
        addChild(bullet)
    
        
    }
    
    
        
    
    
    
    
}



/* Called when a touch begins
for touch in (touches as! Set<UITouch>) {
let location = touch.locationInNode(self)
let sprite = SKSpriteNode(imageNamed:"Spaceship")
sprite.xScale = 0.5
sprite.yScale = 0.5
sprite.position = location
let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
sprite.runAction(SKAction.repeatActionForever(action))
self.addChild(sprite)
}*/
