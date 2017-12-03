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
        let skater = SkaterSprite(imageNamed: "skater")

        skater.zPosition = 5
        skater.physicsBody = SKPhysicsBody(rectangleOf: skater.size) //(circleOfRadius: skaterSprite.size.width / 2)
        
        //Adding contactTestBitMask for skater
        skater.physicsBody?.categoryBitMask = SkaterCategory
        skater.physicsBody?.contactTestBitMask = ThunderDropCategory | WorldCategory
        
        return skater
    }
    
    public func update(deltaTime: TimeInterval){
        
    }
}
