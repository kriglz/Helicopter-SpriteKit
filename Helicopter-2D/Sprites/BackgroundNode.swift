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
    }
}
