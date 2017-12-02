//
//  GameScene.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 11/30/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var lastUpdateTime : TimeInterval = 0
    private var currentThunderDropSpawnTime : TimeInterval = 0
    private var thunderDropSpawnRate : TimeInterval = 0.5
    ///The SKTexture of the thunder.
    let thunderTexture = SKTexture.init(imageNamed: "thunder")
    private let backgroundNode = BackgroundNode()
    
    
    
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        //Setting up and adding to the scene background.
        backgroundNode.setup(size: size)
        addChild(backgroundNode)
        
        //Adding WorldFrame
        var worldFrame = frame
        worldFrame.origin.x = -100
        worldFrame.origin.y = -100
        worldFrame.size.height += 200
        worldFrame.size.width += 200

        self.physicsBody = SKPhysicsBody(edgeLoopFrom: worldFrame)
        self.physicsBody?.categoryBitMask = WorldCategory
        self.physicsWorld.contactDelegate = self

    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update the Spawn Timer
        currentThunderDropSpawnTime += dt
        
        //Spawns new thunder every spawnThunderRate time
        if currentThunderDropSpawnTime > thunderDropSpawnRate {
            currentThunderDropSpawnTime = 0
            spawnThunders()
        }
        
        self.lastUpdateTime = currentTime
    }
    
    //Creates thunders.
    private func spawnThunders(){
        let thunder = SKSpriteNode(texture: thunderTexture)
        thunder.physicsBody = SKPhysicsBody(texture: thunderTexture, size: thunder.size)
        thunder.physicsBody?.categoryBitMask = ThunderDropCategory
        thunder.physicsBody?.contactTestBitMask = FloorCategory | WorldCategory
        
        let xPosition = CGFloat(arc4random()).truncatingRemainder(dividingBy: size.width)
        let yPosition = size.height
        
        thunder.position = CGPoint(x: xPosition, y: yPosition)
        
        addChild(thunder)
    }
   
    //Contact delegate
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == ThunderDropCategory {
            contact.bodyA.node?.physicsBody?.collisionBitMask = 0
//            contact.bodyA.node?.physicsBody?.contactTestBitMask = 0
        
        } else if contact.bodyB.categoryBitMask == ThunderDropCategory {
            contact.bodyB.node?.physicsBody?.collisionBitMask = 0
//            contact.bodyB.node?.physicsBody?.contactTestBitMask = 0
        }
        
        
        if contact.bodyA.categoryBitMask == WorldCategory {
            contact.bodyB.node?.removeFromParent()
            contact.bodyB.node?.physicsBody = nil
            contact.bodyB.node?.removeAllActions()

        } else if contact.bodyB.categoryBitMask == WorldCategory {
            contact.bodyA.node?.removeFromParent()
            contact.bodyA.node?.removeAllActions()
            contact.bodyA.node?.physicsBody = nil
            
        }
    }
}
