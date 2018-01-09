//
//  RCCloudGenerator.swift
//  Invasion
//
//  Created by Ryan Ching on 5/14/15.
//  Copyright (c) 2015 Ryan Ching. All rights reserved.
//

import Foundation
import SpriteKit

class RCStarGenerator: SKSpriteNode {
    
    
    var STAR_WIDTH: CGFloat = 2
    var STAR_HEIGHT: CGFloat = 2
    
    var generationTimer: Timer!
    
    func populate(_ num: Int){
        for i in 0 ..< num {
            
            let num = arc4random_uniform((UInt32)((2)))
            if num == 0 {
                STAR_WIDTH = 1
                STAR_HEIGHT = 1
            }
            else {
                STAR_WIDTH = 2
                STAR_HEIGHT = 2
            }
            let star = RCStar(size: CGSize(width: STAR_WIDTH, height: STAR_HEIGHT))
            let x = CGFloat(arc4random_uniform(UInt32(size.width))) - size.width/2
            let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
            star.position = CGPoint(x: x, y: y)
            star.zPosition = -1            //makes it go behind stuff on screen
            addChild(star)
        }
    }
    
  
    
    
}
