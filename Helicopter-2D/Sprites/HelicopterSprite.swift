//
//  HelicopterSprite.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 12/2/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit

public class HelicopterSprite: SKSpriteNode {
    
    public static func newInstance() -> HelicopterSprite {
        let helicopter = HelicopterSprite(imageNamed: "helicopter")
        
        
        let path = UIBezierPath()
        path.move(to: CGPoint())
        
        let leftCorner = CGPoint(x: -helicopter.size.width / 3 - 5, y: helicopter.size.height / 3)
        let rightCorner = CGPoint(x: helicopter.size.width / 3 + 5, y: helicopter.size.height / 3)
        
        path.addLine(to: leftCorner)
        path.addLine(to: rightCorner)
        
        helicopter.physicsBody = SKPhysicsBody(edgeFrom: leftCorner, to: rightCorner)
        helicopter.physicsBody?.isDynamic = false
        helicopter.physicsBody?.restitution = 0.9
        
        return helicopter
    }
}
