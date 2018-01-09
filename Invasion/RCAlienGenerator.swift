//
//  alienGenerator.swift
//  
//
//  Created by Ryan Ching on 5/9/15.
//
//

import Foundation
import SpriteKit

class RCAlienGenerator: SKSpriteNode {
    
    
  
    var generationTimer: Timer?
    var aliens = [RCAlien]()
    var alienTrackers = [RCAlien]()
    
    
    func startGeneratingAliensEvery(_ seconds: TimeInterval) {
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(RCAlienGenerator.generateAlien), userInfo: nil, repeats: true)
    }
    
    func generateAlien() {
        let alien = RCAlien()
        alien.position.x = size.width/2 + alien.ALIEN_WIDTH/4
        let rand = arc4random_uniform(UInt32(size.height)-UInt32(alien.ALIEN_HEIGHT))
        alien.position.y = CGFloat(rand) - size.height/2 + alien.ALIEN_HEIGHT/2
        aliens.append(alien)
 //       if(aliens[0].position.x < -5){
            
   //     }
        
        alienTrackers.append(alien)
        addChild(alien)
    }
    
    func stopAliens() {
        stopGenerating()
        for alien in aliens {
            alien.stopMoving()
        }
    }

    func stopGenerating() {
        generationTimer?.invalidate()
    }
    
    func removeAllAliens() {
        for alien in aliens {
            alien.removeFromParent()
        }
    }
    
    
}









