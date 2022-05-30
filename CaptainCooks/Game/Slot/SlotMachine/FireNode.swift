//
//  FireNode.swift
//  JackotCity
//
//  Created by Vsevolod Shelaiev on 08.12.2021.
//

import Foundation
import SpriteKit

class FireNode: SKNode {
    
    init(size: CGSize) {
        super.init()
        
        let part = SKEmitterNode(fileNamed: "MyParticle")!
        part.targetNode = self
        self.addChild(part)
        
        let animationTime = 0.5
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
