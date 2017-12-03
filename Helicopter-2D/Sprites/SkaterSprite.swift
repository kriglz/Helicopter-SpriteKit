//
//  SkaterSprite.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 12/2/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit

public class SkaterSprite: SKSpriteNode {
    public static func newInstance() -> SkaterSprite {
        
        //Initializing skater sprite form the image
        let skaterSprite = SkaterSprite(imageNamed: "skater")

        skaterSprite.zPosition = 5
        skaterSprite.physicsBody = SKPhysicsBody(rectangleOf: skaterSprite.size) //(circleOfRadius: skaterSprite.size.width / 2)
        
        //Adding contactTestBitMask for skater
        skaterSprite.physicsBody?.categoryBitMask = skaterCategory
        skaterSprite.physicsBody?.contactTestBitMask = ThunderDropCategory | WorldCategory
        
        return skaterSprite
    }
    
    public func update(deltaTime: TimeInterval){
        
    }
}
