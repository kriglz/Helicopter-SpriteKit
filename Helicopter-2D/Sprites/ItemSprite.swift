//
//  ItemSprite.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 12/2/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit

public class ItemSprite: SKSpriteNode{
    public static func newInstance() -> ItemSprite {
        let item = ItemSprite(imageNamed: "hat")
        
        item.physicsBody = SKPhysicsBody(rectangleOf: item.size)
        item.physicsBody?.categoryBitMask = ItemCategory
        item.physicsBody?.contactTestBitMask = WorldCategory | ThunderDropCategory | SkaterCategory
//        item.physicsBody?.isDynamic = false

        item.zPosition = 5
        
        return item
    }
}
