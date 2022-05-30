//
//  ItemNode.swift
//  slot
//
//  Created by 1 on 19.11.2021.
//

import SpriteKit

class SMItemNode: SKSpriteNode {
    
    let staticTexture: SKTexture
    let movingTexture: SKTexture
    
    init(sqrSize: CGFloat, name: String) {
        staticTexture = .init(imageNamed: "\(name)")
        movingTexture = .init(imageNamed: "\(name)_")
        super.init(texture: staticTexture, color: .clear, size: .init(width: sqrSize, height: sqrSize))
        
        self.anchorPoint = .init(x: 0.5, y: 1)
        self.name = name
    }
    
    var isMoving: Bool = false {
        didSet {
            self.texture = isMoving ? movingTexture : staticTexture
        }
    }
    
    func fire() {
        // change
        self.runParticleAround()
        self.pulse()
    }
    
    func pulse() {
//        let bigScale = 1.15
//        let smalScale = 0.95
//        let qtrScale = 0.25
        let action1: SKAction = SKAction.scale(to: 0.95, duration: 0.25)
        let action2: SKAction = SKAction.scale(to: 1.15, duration: 0.25 * 2)
        let action3: SKAction = SKAction.scale(to: 1.0, duration: 0.25)
//        let sqns: SKAction = SKAction
        self.run(.sequence([action1,action2,action3]))
    }
    
    func runParticleAround() {
        let part = SKEmitterNode(fileNamed: "MyParticle")!
        part.zPosition = 100
        part.position = .init(x: -frame.width / 2, y: -frame.height)
        part.targetNode = self
        self.addChild(part)
        
        let animationTime = 1.0
        let animationTimeQtr = animationTime / 4
                
        let sqns = SKAction.sequence([
            .moveBy(x: size.width, y: 0, duration: animationTimeQtr),
            .moveBy(x: 0, y: size.height, duration: animationTimeQtr),
            .moveBy(x: -size.width, y: 0, duration: animationTimeQtr),
            .moveBy(x: 0, y: -size.height, duration: animationTimeQtr),
            .wait(forDuration: 2),
            .removeFromParent()
        ])
        part.run(.repeatForever(sqns))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


