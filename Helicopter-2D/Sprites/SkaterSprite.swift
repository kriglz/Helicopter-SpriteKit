//
//  SkaterSprite.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 12/2/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit

public class SkaterSprite: SKSpriteNode {
    
    ///Stromg which defines walking action.
    private let walkingActionKey = "action_walking"
    private let walkFrame = [
        SKTexture(imageNamed: "skater1"),
        SKTexture(imageNamed: "skater2"),
        SKTexture(imageNamed: "skater3")
    ]
    
    //Speed of the skater.
    private let movementSpeed: CGFloat = 50
    
    
    public static func newInstance() -> SkaterSprite {
        
        //Initializing skater sprite form the image
        let skater = SkaterSprite(imageNamed: "skater")
        

        skater.zPosition = 5
        skater.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: skater.size.width - 20, height: skater.size.height)) //(circleOfRadius: skaterSprite.size.width / 2)
        
        //Adding contactTestBitMask for skater
        skater.physicsBody?.categoryBitMask = SkaterCategory
        skater.physicsBody?.contactTestBitMask = ThunderDropCategory | WorldCategory
        
        return skater
    }
    
    public func update(deltaTime: TimeInterval, itemLocation: CGPoint){
        if itemLocation.x < position.x {
            //Item is in the left
            position.x -= movementSpeed * CGFloat(deltaTime)
            xScale = 1
        } else {
            //Item is in the right
            position.x += movementSpeed * CGFloat(deltaTime)
            xScale = -1
        }
    }
}
