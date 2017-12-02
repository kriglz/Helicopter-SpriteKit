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
        
        return helicopter
    }
}
