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
    private let scoreNode = SKLabelNode(fontNamed: "Comic-ink")
    private(set) var score: Int = 0
    private var highScore: Int = 0
    ///Defines if highest score is shown now.
    private var showsHighScore = false
    ///Defines if quit button is pressed.
    private(set) var quitButtonPressed = false
    
    //Init of quit button.
    private var quitButton: SKSpriteNode!
    private let quitButtonTexture = SKTexture(imageNamed: "menuQuit")
    private let quitButtonPressedTexture = SKTexture(imageNamed: "menuQuitP")
    
    
    ///Sets up HUD node.
    public func setup(size: CGSize){
        
        //Sets up score label.
        let defaults = UserDefaults.standard
        highScore = defaults.integer(forKey: ScoreKey)
        scoreNode.text = "\(score)"
        scoreNode.fontSize = 50
        scoreNode.position = CGPoint(x: size.width - 60, y: size.height - 120)
        scoreNode.zPosition = 1
        addChild(scoreNode)
        
        //Sets up quit button.
        quitButton = SKSpriteNode(texture: quitButtonTexture)
        quitButton.size = CGSize(width: quitButton.size.width * 1.5, height: quitButton.size.height * 1.5)
        let margin: CGFloat = 35
        quitButton.position = CGPoint(x: size.width - quitButton.size.width + margin, y: size.height - quitButton.size.height)
        quitButton.zPosition = 10000
        addChild(quitButton)
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
            defaults.set(score, forKey: ScoreKey)
            
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
