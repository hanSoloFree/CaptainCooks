//
//  SoloSlotNode.swift
//  slot
//
//  Created by 1 on 19.11.2021.
//

import SpriteKit
var names = ["Element1", "Element2", "Element3"]
// using two extra item on top and one on bottom
class SMColumnNode: SKCropNode {
    
    let count: Int
    let tickTime = 0.06
    let offSetHalfTime = 0.15
    let tickOffset: CGFloat = 16
    let ticks = 24
    
    let itemHeight: CGFloat
    let containerNode = SKNode()
    var items = [SMItemNode]()
        
    var complition: (() -> Void)?
    
    var lowestItem: SKSpriteNode? {
        let sorted = items.sorted { $0.position.y < $1.position.y }
        return sorted.first
    }
    var visibleItems: [SMItemNode] {
        let sorted = items.sorted { $0.position.y > $1.position.y }
        let exeptFirstAndLostTwo = sorted[2...(count + 1)]
        return Array(exeptFirstAndLostTwo)
    }
    var slotHeight: CGFloat { itemHeight * CGFloat(count) }
    
    init(width: CGFloat, rows: Int) {
        self.count = rows
        self.itemHeight = width
        super.init()
        
        self.addChild(containerNode)
        
        for i in -2...count {
            let name = names.randomElement()!
            let item = SMItemNode(sqrSize: width - 20, name: name)
            let yPosition = CGFloat(-i) * width - 10
            item.position.y = yPosition
            containerNode.addChild(item)
            items.append(item)
        }

        let maskNode = SKSpriteNode(color: .white, size: CGSize(width: width, height: slotHeight))
        maskNode.anchorPoint = .init(x: 0.5, y: 1)
        self.maskNode = maskNode
    }
    
    func start() {
        tickFor(times: ticks)
    }
    
    func tickFor(times: Int) {
        switch times {
        case 0:
            tickLast {
                self.complition?()
            }
        case ticks:
            tickFirst {
                self.tickFor(times: times - 1)
            }
        default:
            tickAll {
                self.tickFor(times: times - 1)
            }
        }
    }
    
    func tickAll(complition: (() -> Void)?) {
        let sqns = SKAction.sequence([
            .moveBy(x: 0, y: -itemHeight, duration: tickTime),
            .run { self.moveLowestItemUp() }
        ])
        containerNode.run(sqns) {
            complition?()
        }
    }
    
    func tickFirst(complition: (() -> Void)?) {
        let sqns = SKAction.sequence([
            .moveBy(x: 0, y: tickOffset, duration: offSetHalfTime),
            .run { self.switchItemsTextures(isMoving: true) },
            .moveBy(x: 0, y: -itemHeight - tickOffset, duration: tickTime),
            .run { self.moveLowestItemUp() }
        ])
        containerNode.run(sqns) {
            complition?()
        }
    }
    
    func tickLast(complition: (() -> Void)?) {
        let sqns = SKAction.sequence([
            .moveBy(x: 0, y: -itemHeight - tickOffset, duration: tickTime),
            .run { self.switchItemsTextures(isMoving: false) },
            .moveBy(x: 0, y: tickOffset, duration: offSetHalfTime),
            .run { self.moveLowestItemUp() }
        ])
        containerNode.run(sqns) {
            complition?()
        }
    }
    
    func moveLowestItemUp() {
        if let lowestItem = lowestItem {
            lowestItem.position.y += itemHeight * CGFloat((count + 3))
        }
    }
    
    func switchItemsTextures(isMoving: Bool) {
        items.forEach {
            $0.isMoving = isMoving
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
