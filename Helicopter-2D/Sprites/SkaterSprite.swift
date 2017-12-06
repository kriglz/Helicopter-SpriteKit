//
//  SkaterSprite.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 12/2/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit

public class SkaterSprite: SKSpriteNode {
    
    ///String which defines walking action.
    private let skatingActionKey = "action_walking"
    private let skateFrame = [
        SKTexture(imageNamed: "skater1"),
        SKTexture(imageNamed: "skater2"),
        SKTexture(imageNamed: "skater3")
    ]
    //Sound effects for hit action.
    private let skaterSFX = [
        "scream.mp3"
    ]
    
    //Speed of the skater.
    private let movementSpeed: CGFloat = 50
    
    //Constants for hit action.
    private var timeSinceLastHit: TimeInterval = 2.0
    private let maxFlailTime = 2.0
    
    ///Int which counts how many times skater was hit by thunder.
    private var currentThunderHits = 1
    ///Int which defines how many times skater needs to be hit before moaning.
    private let maxThunderHits = 1
    
    
    
    
    
    
    ///Creates new skater node.
    public static func newInstance() -> SkaterSprite {
        let skater = SkaterSprite(imageNamed: "skater2")

        skater.zPosition = 5
        skater.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: skater.size.width - 70, height: skater.size.height - 20)) //(circleOfRadius: skaterSprite.size.width / 2)
        skater.physicsBody?.allowsRotation = false
        
        //Adding contactTestBitMask for skater
        skater.physicsBody?.categoryBitMask = SkaterCategory
        skater.physicsBody?.contactTestBitMask = ThunderDropCategory | WorldCategory
        
        return skater
    }
    
    
    ///Updates skater on the screen.
    public func update(deltaTime: TimeInterval, itemLocation: CGPoint){
        timeSinceLastHit += deltaTime
        
        //Checks if skater was hit.
        if timeSinceLastHit >= maxFlailTime {
            
            //Adds skating action.
            if action(forKey: skatingActionKey) == nil {
                let skatingAction = SKAction.repeatForever(
                    SKAction.animate(with: skateFrame,
                                     timePerFrame: 0.2,
                                     resize: false,
                                     restore: true)
                )
                run(skatingAction, withKey: skatingActionKey)
            }

            
            //Corrects the angular rotation.
            if zRotation != 0 && action(forKey: "action_rotate") == nil {
                run(SKAction.rotate(toAngle: 0, duration: 0.25), withKey: "action_rotate")
            }
            
            
            //Stand still if the item is above the skater.
            if itemLocation.y > position.y && abs(itemLocation.x - position.x) < 2 {
                physicsBody?.velocity.dx = 0
                removeAction(forKey: skatingActionKey)
                texture = skateFrame[1]
            } else if itemLocation.x < position.x {
                //Item is in the left
                position.x -= movementSpeed * CGFloat(deltaTime)
                xScale = 1
            } else {
                //Item is in the right
                position.x += movementSpeed * CGFloat(deltaTime)
                xScale = -1
            }
            
            physicsBody?.angularVelocity = 0
        }
    }
    
    
    ///Updates skater on the screen after thunder hit action.
    public func hitByThunder(){
        timeSinceLastHit = 0
        removeAction(forKey: skatingActionKey)
        
        //Mutes if sound is off.
        guard !SoundManager.sharedInstance.isMuted else {
            return
        }
        
        //Determines if skater needs to moan.
        if currentThunderHits < maxThunderHits {
            currentThunderHits += 1
            return
        }
        
        if action(forKey: "action_sound_effect") == nil {
            currentThunderHits = 0
            
            let selectedSFX = Int( arc4random_uniform( UInt32( skaterSFX.count)))
            run( SKAction.playSoundFileNamed( skaterSFX[selectedSFX], waitForCompletion: true), withKey: "action_sound_effect")
        }
    }
}
