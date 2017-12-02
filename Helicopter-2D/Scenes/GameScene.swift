//
//  GameScene.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 11/30/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var lastUpdateTime : TimeInterval = 0
    private var currentThunderDropSpawnTime : TimeInterval = 0
    private var thunderDropSpawnRate : TimeInterval = 0.5
    private let backgroundNode = BackgroundNode()
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        //Setting up and adding to the scene background.
        backgroundNode.setup(size: size)
        addChild(backgroundNode)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update the Spawn Timer
        currentThunderDropSpawnTime += dt
        
        
        self.lastUpdateTime = currentTime
    }
   
}
