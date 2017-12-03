//
//  PortalSprite.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 12/2/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit

public class PortalSprite: SKSpriteNode{
    public static func newInstance() -> PortalSprite {
        let port = PortalSprite(imageNamed: "port")
        
        port.physicsBody = SKPhysicsBody(rectangleOf: port.size)
        port.physicsBody?.categoryBitMask = PortalCategory
        port.physicsBody?.contactTestBitMask = WorldCategory | ThunderDropCategory | SkaterCategory
        port.physicsBody?.isDynamic = false

        port.zPosition = 5
        
        return port
    }
}
