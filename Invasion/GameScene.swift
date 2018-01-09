

//
//  GameScene.swift
//  Invasion
//
//  Created by Ryan Ching on 5/9/15.
//  Copyright (c) 2015 Ryan Ching. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var earth: SKSpriteNode!
    var alienGenerator: RCAlienGenerator!
    var isStarted = false
    var bulletReady = true
    
    var gameOverLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var tapToStartLabel: SKLabelNode!
    var highscoreLabel: SKLabelNode!
    
    var score = 0
    var bullets = [RCBullet]()
    var generators = [RCAlienGenerator]()
    
    var timer: Timer!
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.black
        physicsWorld.contactDelegate = self

        makeEarth()
        addStartLabel()
        
        let starGenerator = RCStarGenerator(color: UIColor.clear, size: view.frame.size)
        starGenerator.position = view.center
        addChild(starGenerator)
        starGenerator.populate(35)
        
        
        
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.name = "tapToStartLabel"
        scoreLabel.position = CGPoint(x: 25, y: size.height-30)
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontColor = UIColor.white
        scoreLabel.fontSize = 28.0
        addChild(scoreLabel)
        

        highscoreLabel = SKLabelNode(text: "Highscore: 0")
        highscoreLabel.name = "tapToStartLabel"
        highscoreLabel.position = view.center
        highscoreLabel.fontName = "Helvetica"
        highscoreLabel.fontColor = UIColor.white
        highscoreLabel.fontSize = 28.0
        addChild(highscoreLabel)
        highscoreLabel.isHidden = false
        loadHighscore()
        
    }
    
    func startGame() {
        addAlienGenerator()
        isStarted = true
        alienGenerator.startGeneratingAliensEvery(1.5)
        tapToStartLabel.isHidden = true
        tapToStartLabel.removeFromParent()
        if(gameOverLabel != nil){
            gameOverLabel.isHidden = true
            gameOverLabel.removeFromParent()
        }
        
        scoreLabel.text = "0"
        score = 0
        
        highscoreLabel.isHidden = true
    }
    
    func gameOver() {
        //alienGenerator.stopAliens()
        for RCAlienGenerator in generators {
            RCAlienGenerator.stopAliens()
            RCAlienGenerator.removeAllAliens()
            RCAlienGenerator.removeFromParent()
        }
        
        //alienGenerator.removeFromParent()
        isStarted = false
        tapToStartLabel = SKLabelNode(text: "Game over")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position = highscoreLabel.position
        tapToStartLabel.fontName = "Helvetica"
        tapToStartLabel.fontColor = UIColor.white
        tapToStartLabel.position.y += 40
        tapToStartLabel.fontSize = 35.0
        addChild(tapToStartLabel)
        
        removeAllBullets()
        
        gameOverLabel = SKLabelNode(text: "Tap to start again!")
        gameOverLabel.name = "tapToStartLabel"
        gameOverLabel.position = highscoreLabel.position
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.fontColor = UIColor.white
        gameOverLabel.position.y -= 40
        gameOverLabel.fontSize = 35.0
        addChild(gameOverLabel)
        
         let defaults = UserDefaults.standard
        if score > defaults.integer(forKey: "highscore"){
            defaults.set(score, forKey: "highscore")
        }
        loadHighscore()
        highscoreLabel.isHidden = false
    
    }
    
    func addStartLabel() {
        tapToStartLabel = SKLabelNode(text: "Tap to start!")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position = view!.center
        tapToStartLabel.fontName = "Helvetica"
        tapToStartLabel.fontColor = UIColor.white
        tapToStartLabel.position.y += 40
        tapToStartLabel.fontSize = 35.0
        addChild(tapToStartLabel)
    }
    
    func addAlienGenerator() {
        alienGenerator = RCAlienGenerator(color: UIColor.clear, size: view!.frame.size)
        alienGenerator.position = view!.center
        addChild(alienGenerator)
        generators.append(alienGenerator)
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isStarted {
            let touch = touches.first! as UITouch
            let point = touch.location(in: self.view)
            fireBullet(point)
        }
        else {
            if alienGenerator != nil {
                alienGenerator.removeAllAliens()
                alienGenerator.removeFromParent()
            }
            
            startGame()
        }
        
        
    }
   
    func fireBullet(_ touchLocation: CGPoint) {
        if bulletReady{
            let bullet = RCBullet()
            bullet.position = earth.position//CGPointMake(83, view!.frame.size.height/2)
            bullet.position.x += earth.size.width/2 - 20
            addChild(bullet)
            bullets.append(bullet)
            bullet.fire(touchLocation)
            timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(GameScene.bulletReadyUpdate), userInfo: nil, repeats: false)
            bulletReady = false
        }
    }
    
    func bulletReadyUpdate() {
        bulletReady = true;
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
 
        if (contact.bodyA.categoryBitMask == bulletCategory && contact.bodyB.categoryBitMask == alienCategory) || (contact.bodyA.categoryBitMask == alienCategory && contact.bodyB.categoryBitMask == bulletCategory) {
            print("ALIEN HIT")
           // delete(contact.bodyA)
           // delete(contact.bodyB)
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            
            score += 1
            scoreLabel.text = "\(score)"
            
            if score%5 == 0 {
                let newGenerator = RCAlienGenerator(color: UIColor.clear, size: view!.frame.size)
                newGenerator.startGeneratingAliensEvery(8)
                newGenerator.position = view!.center
                addChild(newGenerator)
                generators.append(newGenerator)
            }
            
            
        }
        else if (contact.bodyA.categoryBitMask == earthCategory && contact.bodyB.categoryBitMask == alienCategory) || (contact.bodyA.categoryBitMask == alienCategory && contact.bodyB.categoryBitMask == earthCategory) {
            print("EARTH HIT")
            gameOver()
        }
        
    }
    
    func loadHighscore() {
        let defaults = UserDefaults.standard
        let loadedHighScore = defaults.integer(forKey: "highscore")
        highscoreLabel.text = "Highscore: \(loadedHighScore)"
        
    }
    
    func removeAllBullets() {
        for bullet in bullets{
            bullet.removeFromParent()
        }
    }
    
    func makeEarth() {
        earth = SKSpriteNode(imageNamed: "newearth.png")
        
        earth.position = CGPoint(x: -100,y: view!.frame.height/2)
        earth.size = CGSize(width: view!.frame.height+150, height: view!.frame.height+130)
        addChild(earth)

        physicsBody = SKPhysicsBody(circleOfRadius: earth.size.width/2 - 20, center: earth.position)
        physicsBody?.categoryBitMask = earthCategory
        physicsBody?.contactTestBitMask = alienCategory
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}


















