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
    private var thunderDropSpawnRate : TimeInterval = 1
    private let itemEdgeMargin: CGFloat = 25.0
    ///The SKTexture of the thunder.
    let thunderTexture = SKTexture.init(imageNamed: "thunder")
    private let backgroundNode = BackgroundNode()
    private var helicopterNode: HelicopterSprite!
    private var itemNode: ItemSprite!
    private var skaterNode: SkaterSprite!
    
    
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        //Setting up and adding to the scene background.
        backgroundNode.setup(size: size)
        addChild(backgroundNode)
        
        //Adding helicopter to the scene.
        spawnHelicopter()

        //Adding skater to the scene.
        spawnSkater()
        
        //Adding port to the scene.
        spawnItem()
        
        //Adding WorldFrame
        var worldFrame = frame
        worldFrame.origin.x = -100
        worldFrame.origin.y = -100
        worldFrame.size.height += 200
        worldFrame.size.width += 200

        self.physicsBody = SKPhysicsBody(edgeLoopFrom: worldFrame)
        self.physicsBody?.categoryBitMask = WorldCategory
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector.init(dx: 0.1, dy: -1.0)

    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        if let touchPoint = touchPoint {
            helicopterNode.setDestination(destination: touchPoint)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        if let touchPoint = touchPoint{
            helicopterNode.setDestination(destination: touchPoint)
        }
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
        
        //Updates helicopter
        helicopterNode.update(deltaTime: dt)

        //Updates skater movement
        skaterNode.update(deltaTime: dt, itemLocation: itemNode.position)
        
        self.lastUpdateTime = currentTime
    }
    
    
    
    
    
    
    
    //Creates thunders.
    private func spawnThunders(){
        let thunder = SKSpriteNode(texture: thunderTexture)
        thunder.physicsBody = SKPhysicsBody(texture: thunderTexture, size: thunder.size)
        thunder.physicsBody?.density = 0.5
        thunder.physicsBody?.allowsRotation = false
        thunder.physicsBody?.categoryBitMask = ThunderDropCategory
        thunder.physicsBody?.contactTestBitMask = WorldCategory //FloorCategory | WorldCategory
        
        let xPosition = CGFloat(arc4random()).truncatingRemainder(dividingBy: size.width)
        let yPosition = size.height
        
        thunder.position = CGPoint(x: xPosition, y: yPosition)
        thunder.zPosition = 2
        
        addChild(thunder)
    }
    
    //Creates helicopter
    func spawnHelicopter(){
        //Checks if the helicopter already exists.
        if let currentHelicopter = helicopterNode, children.contains(currentHelicopter){
            helicopterNode.removeFromParent()
            helicopterNode.removeAllActions()
            helicopterNode.physicsBody = nil
        }
        
        helicopterNode = HelicopterSprite.newInstance()
        helicopterNode.updatePosition(point: CGPoint(x: frame.midX, y: frame.midY))
        
        addChild(helicopterNode)
    }

    //Creates skater.
    func spawnSkater(){
        //Checks if the skater already exists.
        if let currentSkater = skaterNode, children.contains(currentSkater){
            skaterNode.removeFromParent()
            skaterNode.removeAllActions()
            skaterNode.physicsBody = nil
        }
        
        skaterNode = SkaterSprite.newInstance()
        skaterNode.position = CGPoint(x: helicopterNode.position.x, y: size.height * 0.15)

        addChild(skaterNode)
    }
    
    //Creates item.
    func spawnItem(){
        //Checks if the item already exists.
        if let currentItem = itemNode, children.contains(currentItem){
            itemNode.removeFromParent()
            itemNode.removeAllActions()
            itemNode.physicsBody = nil
        }
        
        itemNode = ItemSprite.newInstance()
        var randomPosition: CGFloat = CGFloat(arc4random())
        randomPosition = randomPosition.truncatingRemainder(dividingBy: (size.width - itemEdgeMargin * 2))
        randomPosition += itemEdgeMargin
        
        itemNode.position = CGPoint(x: randomPosition, y: size.height * 0.15)
        
        addChild(itemNode)
    }
    
    
   
    
    
    
    
    //Contact delegate
    func didBegin(_ contact: SKPhysicsContact) {
        
        //Checks if item was hit.
        if contact.bodyA.categoryBitMask == ItemCategory || contact.bodyB.categoryBitMask == ItemCategory {
            handleItemCollision(contact: contact)
            return
        }
        
        //Checks if skater was hit.
        if contact.bodyA.categoryBitMask == SkaterCategory || contact.bodyB.categoryBitMask == SkaterCategory {
            handleSkaterCollision(contact: contact)
            return
        }
        
        //Checks if helicopter was hit.
        if contact.bodyA.categoryBitMask == HelicopterCategory || contact.bodyB.categoryBitMask == HelicopterCategory {
            handleHelicopterCollision(contact: contact)
            return
        }
        
        //After first hit thunder does not bounce anymore
        if contact.bodyA.categoryBitMask == ThunderDropCategory {
            contact.bodyA.node?.physicsBody?.collisionBitMask = 0
        } else if contact.bodyB.categoryBitMask == ThunderDropCategory {
            contact.bodyB.node?.physicsBody?.collisionBitMask = 0
        }
        
        //Removes node, when it hits worldframe.
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
    
    
    
    
    
    //Finds out if thunder hit helicopter
    private func handleHelicopterCollision(contact: SKPhysicsContact) {
        var otherBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask == HelicopterCategory {
            otherBody = contact.bodyB
        } else {
            otherBody = contact.bodyA
        }
        
        switch otherBody.categoryBitMask {
        case ThunderDropCategory:
            thunderStrike(to: otherBody.node)
            helicopterNode.hitByThunder()

        default:
            print("Something hit helicopter")
        }
    }
    
    //Finds out with which body skater collided.
    private func handleSkaterCollision(contact: SKPhysicsContact){
        var otherBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask == SkaterCategory {
            otherBody = contact.bodyB
        } else {
            otherBody = contact.bodyA
        }
        
        switch otherBody.categoryBitMask {
        case ThunderDropCategory:
            //Thunder hits the skater.
            skaterNode.hitByThunder()
            
            thunderStrike(to: otherBody.node)
            
        case WorldCategory:
            spawnSkater()
            
        default:
            print("Something hit skater")
        }
    }
    
    //Finds put with which body item collided.
    private func handleItemCollision(contact: SKPhysicsContact){
        var otherBody: SKPhysicsBody
        var itemBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask == ItemCategory {
            otherBody = contact.bodyB
            itemBody = contact.bodyA
        } else {
            otherBody = contact.bodyA
            itemBody = contact.bodyB
        }
        
        switch otherBody.categoryBitMask {
            
        case SkaterCategory:
            //TODO increment points
            fallthrough //picks the following case (doesn't matter if that matches or not)
            
        case WorldCategory:
            itemBody.node?.removeFromParent()
            itemBody.node?.physicsBody = nil
            spawnItem()
            
        default:
            print("something else touched item")
        }
    }
    
    //Removes thunder after hit.
    private func thunderStrike(to thunder: SKNode?){
        thunder?.physicsBody?.velocity = CGVector.zero
        
        thunder?.removeFromParent()
        thunder?.physicsBody = nil
    }
}
