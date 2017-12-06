//
//  MenuScene.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 12/5/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    let startButtonTexture = SKTexture(imageNamed: "menuStart")
    let startButtonPressedTexture = SKTexture(imageNamed: "menuStartP")
    let soundButtonTexture = SKTexture(imageNamed: "speakerOn")
    let soundButtonOffTexture = SKTexture(imageNamed: "speakerOff")
    
    let logoSprite = SKSpriteNode(imageNamed: "gameTitle")
    var startButton: SKSpriteNode! = nil
    var soundButton: SKSpriteNode! = nil
    
    let highScoreNode = SKLabelNode(fontNamed: "Comic-ink")
    
    var selectedButton: SKSpriteNode?
    
    override func sceneDidLoad() {
        backgroundColor = SKColor(red: 0.99, green: 0.92, blue: 0.55, alpha: 1.0)
        
        //Sets up logo - sprite is initialized later
        logoSprite.position = CGPoint(x: size.width / 2, y: size.height / 2 + 100)
        logoSprite.size = CGSize(width: logoSprite.size.width * 3, height: logoSprite.size.height * 3)
        addChild(logoSprite)
        
        //Sets up start button.
        startButton = SKSpriteNode(texture: startButtonTexture)
        startButton.position = CGPoint(x: size.width / 2, y: size.height / 2 - startButton.size.height / 2)
        startButton.size = CGSize(width: startButton.size.width * 4, height: startButton.size.height * 4)
        addChild(startButton)
        
        let edgeMargin: CGFloat = 25
        
        //Sets up sound button.
        soundButton = SKSpriteNode(texture: soundButtonTexture)
        soundButton.position = CGPoint(x: size.width - soundButton.size.width / 2 - edgeMargin, y: soundButton.size.height / 2 + edgeMargin)
        addChild(soundButton)
        
        //Sets up high-score node.
        let defaults = UserDefaults.standard
        let highScore = defaults.integer(forKey: ScoreKey)
        highScoreNode.text = "\(highScore)"
        highScoreNode.fontSize = 70
        highScoreNode.verticalAlignmentMode = .top
        highScoreNode.position = CGPoint(x: size.width / 2, y: startButton.position.y - startButton.size.height / 2 - 50)
        highScoreNode.zPosition = 1
        addChild(highScoreNode)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if selectedButton != nil {
                handleStartButtonHover(isHovering: false)
                handleSoundButtonHover(isHovering: false)
            }
            
            //Checks which button was clicked if any.
            if startButton.contains( touch.location(in: self)){
                selectedButton = startButton
                handleStartButtonHover(isHovering: true)
            } else if soundButton.contains( touch.location(in: self)){
                selectedButton = soundButton
                handleSoundButtonHover(isHovering: false)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            //Check which button was clicked if any
            if selectedButton == startButton {
                handleStartButtonHover(isHovering: startButton.contains( touch.location(in: self)))
            } else if selectedButton == soundButton {
                handleSoundButtonHover(isHovering: soundButton.contains( touch.location(in: self)))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            
            if selectedButton == startButton {
                handleStartButtonHover(isHovering: false)
                
                if startButton.contains(touch.location(in: self)) {
                    handleStartButtonCLick()
                }
            } else if selectedButton == soundButton {
                handleSoundButtonHover(isHovering: false)
                
                if soundButton.contains( touch.location(in: self)){
                    handleSoundButtonClicked()
                }
            }
        }
        
        selectedButton = nil
    }
    
    
    
    ///Handles start button hover behaviour.
    private func handleStartButtonHover(isHovering: Bool){
        if isHovering {
            startButton.texture = startButtonPressedTexture
        } else {
            startButton.texture = startButtonTexture
        }
    }
    
    ///Handles sound button hover.
    private func handleSoundButtonHover(isHovering: Bool) {
        if isHovering {
            soundButton.alpha = 0.5
        } else {
            soundButton.alpha = 1.0
        }
    }
    
    
    ///Handles start button behaviour.
    private func handleStartButtonCLick(){
        let transition = SKTransition.reveal(with: .down, duration: 0.75)
        let gameScene = GameScene(size: size)
        gameScene.scaleMode = scaleMode
        view?.presentScene(gameScene, transition: transition)
    
    }
    
    ///Handles sound button behaviour.
    private func handleSoundButtonClicked(){
        print("Sound clicked")
    }
    
}
