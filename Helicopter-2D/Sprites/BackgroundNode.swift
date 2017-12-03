//
//  BackgroundNode.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 12/1/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit

public class BackgroundNode: SKNode {
    
    public func setup(size: CGSize) {
        let yPosition: CGFloat = size.height * 0.10
        let startPoint = CGPoint(x: 0, y: yPosition)
        let endPoint = CGPoint(x: size.width, y: yPosition)
        
        physicsBody = SKPhysicsBody(edgeFrom: startPoint, to: endPoint)
        physicsBody?.restitution = 0.3
        physicsBody?.categoryBitMask = FloorCategory
        physicsBody?.contactTestBitMask = ThunderDropCategory
        
        let sky = SKShapeNode(rect: CGRect(origin: CGPoint(), size: size))
        sky.fillColor = SKColor(red: 0, green: 0, blue: 128/255, alpha: 1.0)
        sky.strokeColor = SKColor.clear
        sky.zPosition = 0
        
        let groundSize = CGSize(width: size.width, height: size.height * 0.25)
        let ground = SKShapeNode(rect: CGRect(origin: CGPoint(), size: groundSize))
        ground.fillColor = SKColor(red: 0.99, green: 0.92, blue: 0.55, alpha: 1.0)
        ground.strokeColor = SKColor.clear
        ground.zPosition = 1
        
        addChild(sky)
        addChild(ground)
    }
}
