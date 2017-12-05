//
//  HudNode.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 12/5/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit

class HudNode: SKNode {
//    private let scoreKey = "skater_highscore"
    private let scoreNode = SKLabelNode(fontNamed: "Cmmic-ink")
    private(set) var score: Int = 0
    private var highScore: Int = 0
    ///Defines if highest score is shown now.
    private var showsHighScore = false
    
    ///Sets up HUD node.
    public func setup(size: CGSize){
        let defaults = UserDefaults.standard
        
        highScore = defaults.integer(forKey: scoreKey)
        
        scoreNode.text = "\(score)"
        scoreNode.fontSize = 50
        scoreNode.position = CGPoint(x: size.width / 2, y: size.height - 100)
        scoreNode.zPosition = 1
        
        addChild(scoreNode)
    }
    
    
    ///Add point.
    /// - Increments the score.
    /// - Saves to user defaults.
    /// - If a high score is achieved, then enlarges the scoreNode and uodates the color.
    public func addPoint(){
        score += 1
        
        updateScoreboard()
        
        if score > highScore {
            let defaults = UserDefaults.standard
            defaults.set(score, forKey: scoreKey)
            
            if !showsHighScore {
                showsHighScore = true
                
                scoreNode.run( SKAction.scale(to: 1.5, duration: 0.25))
                scoreNode.fontColor = SKColor(red: 0.99, green: 0.92, blue: 0.55, alpha: 1.0)
            }
        }
    }
    
    
    ///Updates the score label to show the current score.
    private func updateScoreboard() {
        scoreNode.text = "\(score)"
    }
    
    
    ///Reset point.
    /// - Set score to zero.
    /// - Updates score label.
    /// - Resets color and size to default value.
    public func resetPoints(){
        score = 0
        
        updateScoreboard()
        
        if showsHighScore{
            showsHighScore = false
            scoreNode.run( SKAction.scale(to: 1.0, duration: 0.25))
            scoreNode.fontColor = SKColor.white
        }
    }
}
