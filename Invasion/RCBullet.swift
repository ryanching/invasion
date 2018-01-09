//
//  File.swift
//  Invasion
//
//  Created by Ryan Ching on 5/10/15.
//  Copyright (c) 2015 Ryan Ching. All rights reserved.
//

import Foundation
import SpriteKit

class RCBullet: SKSpriteNode {

    let BULLET_WIDTH: CGFloat = 8
    let BULLET_HEIGHT: CGFloat = 8
    
    init() {
        let size = CGSize(width: BULLET_WIDTH, height: BULLET_HEIGHT)
        let texture = SKTexture(imageNamed: "bullet.png")
        super.init(texture: texture, color: UIColor.clear, size: size)
        loadPhysicsBodyWithSize(size)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fire(_ touchLocation: CGPoint) {
        
   //     let touchLocation = vecNoramlize(touchLocation2)
        let distanceFromX = touchLocation.x - self.position.x
        
        let deltaY = self.position.y - touchLocation.y
        let deltaX = -(self.position.x - touchLocation.x)
        let slope = deltaY / deltaX
        
        let vectorX: CGFloat = 200
        let vectorY: CGFloat = vectorX * slope
        
        let magnitude = sqrt(vectorX*vectorX + vectorY*vectorY)
        let unitVectorX: CGFloat = vectorX/magnitude                        //UNIT VECTORS IM SO FUCKING SMART
        let unitVectorY: CGFloat = vectorY/magnitude

        let vector: CGVector = CGVector(dx: unitVectorX*200, dy: 200*unitVectorY)
        let fire = SKAction.move(by: vector, duration: 0.5)
        run(SKAction.repeatForever(fire))
    }
    
    func loadPhysicsBodyWithSize(_ size: CGSize) {

        physicsBody = SKPhysicsBody(circleOfRadius: BULLET_WIDTH/2)
        physicsBody?.categoryBitMask = bulletCategory
        physicsBody?.contactTestBitMask = alienCategory
        physicsBody?.affectedByGravity = false

    }
    
    func vecAdd(_ a:CGPoint,b:CGPoint)->CGPoint{
        return CGPoint(x: a.x + b.x, y: a.y + b.y);
    }
    
    func vecSub(_ a:CGPoint, b:CGPoint)->CGPoint{
        return CGPoint(x: a.x - b.x, y: a.y - b.y);
    }
    
    func vecMulti(_ a:CGPoint,b:CGFloat)->CGPoint{
        return CGPoint(x: a.x * b, y: a.y * b);
    }
    
    func vecLength (_ a:CGPoint)->CGFloat{
        return CGFloat(sqrtf(CFloat(a.x) * CFloat(a.x) + CFloat(a.y) * CFloat(a.y)));
    }
    
    func vecNoramlize (_ a:CGPoint)->CGPoint{
        let length:CGFloat = self.vecLength(a)
        return CGPoint(x: a.x / length, y: a.y / length);
    }
    
    
}





