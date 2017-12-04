//
//  HelicopterSprite.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 12/2/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit

public class HelicopterSprite: SKSpriteNode {
    
    ///String which defines flying action.
    private let flyingActionKey = "action_flying"
    private let flyFrame = [
        SKTexture(imageNamed: "helicopter1"),
        SKTexture(imageNamed: "helicopter2"),
        SKTexture(imageNamed: "helicopter3"),
        SKTexture(imageNamed: "helicopter4")

    ]
    
    private var destination: CGPoint!
    private let easings: CGFloat = 0.1
    
    public static func newInstance() -> HelicopterSprite {
        let helicopter = HelicopterSprite(imageNamed: "helicopter1")
        helicopter.size = CGSize(width: helicopter.size.width / 2, height: helicopter.size.height / 2)
        
        
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
    
    public func updatePosition(point: CGPoint){
        position = point
        destination = point
    }
    
    public func setDestination(destination: CGPoint){
        self.destination = destination
    }
    
    public func update(deltaTime: TimeInterval){
        if action(forKey: flyingActionKey) == nil {
            let flyingAction = SKAction.repeatForever(
                SKAction.animate(with: flyFrame, timePerFrame: 0.1, resize: false, restore: true)
            )
            run(flyingAction, withKey: flyingActionKey)
        }
        
        let distance = sqrt(pow((destination.x - position.x), 2) + pow((destination.y - position.y), 2))
        
        if distance > 1 {
            let directionX = destination.x - position.x
            let directionY = destination.y - position.y
            
            position.x += directionX * easings
            position.y += directionY * easings
        } else {
            position = destination
        }
    }
}
