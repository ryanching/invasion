//
//  RCAlien.swift
//  Invasion
//
//  Created by Ryan Ching on 5/9/15.
//  Copyright (c) 2015 Ryan Ching. All rights reserved.
//

import Foundation
import SpriteKit


class RCAlien: SKSpriteNode {
    
    let ALIEN_WIDTH: CGFloat = 70.0
    let ALIEN_HEIGHT: CGFloat = 25.0
    
    
    init(){
        let size = CGSize(width: ALIEN_WIDTH, height: ALIEN_HEIGHT)
        let texture = SKTexture(imageNamed: "alien.png")
        super.init(texture: texture, color: UIColor.clear, size: size)
        loadPhysicsBodyWithSize(size)
        startMoving()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving() {
        let rand = arc4random_uniform(5)
        let moveLeft: SKAction!
        if rand == 0 {
            //let speed = moveByXPerSecond + 100
            moveLeft = SKAction.moveBy(x: -(moveByXPerSecond + CGFloat(100)), y: 0, duration: 1)
        }
        else if rand == 1 {
            moveLeft = SKAction.moveBy(x: -(moveByXPerSecond + CGFloat(50)), y: 0, duration: 1)
        }
        else {
        //    let speed = moveByXPerSecond
            moveLeft = SKAction.moveBy(x: -moveByXPerSecond, y: 0, duration: 1)
        }
        
      //  let moveLeft = SKAction.moveByX(-moveByXPerSecond, y: 0, duration: 1)
        run(SKAction.repeatForever(moveLeft))
    }
    
    func loadPhysicsBodyWithSize(_ size: CGSize) {
        let texture = SKTexture(imageNamed: "alien.png")
        //physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = alienCategory
        physicsBody?.allowsRotation = false
     //   physicsBody?.contactTestBitMask = bulletCategory
        physicsBody?.affectedByGravity = false
        
    }
    
    func stopMoving() {
        removeAllActions()
    }
    
   
}







