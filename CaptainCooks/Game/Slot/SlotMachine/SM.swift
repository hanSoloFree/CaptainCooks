//
//  Slot.swift
//  slot
//
//  Created by 1 on 19.11.2021.
//

import SpriteKit

class SM: SKSpriteNode {
    
    var bet = 10
    lazy var slotBrain = SMBrain(slotMachine: self)
    let rowWidth: CGFloat

    var allItems: [SMItemNode] {
        var allItems = [SMItemNode]()
        for soloSlot in slots {
            let items = soloSlot.visibleItems
            allItems.append(contentsOf: items)
        }
        return allItems
    }
    
    var slots: [SMColumnNode] = []

    var complition: ((Int) -> Void)?
    
    init(rows: Int = 3, cols: Int = 5, size: CGSize) {
        let proportion = CGFloat(cols) / CGFloat(rows)
        let isLong = (size.width / size.height) > proportion
        self.rowWidth = isLong ? size.height / CGFloat(rows) : size.width / CGFloat(cols)
        super.init(texture: nil, color: .clear, size: size)
        
        let yOffSet: CGFloat = CGFloat(rows) * 0.5 * rowWidth
        let xOffSet: CGFloat = CGFloat(cols) * 0.5 * rowWidth
        for i in 0..<cols {
            let slot = SMColumnNode(width: rowWidth, rows: rows)
            slot.position.x = CGFloat(i) * rowWidth + rowWidth / 2 - xOffSet
            slot.position.y = yOffSet
            self.addChild(slot)
            slots.append(slot)
            
            let isLast = i == cols - 1
            if isLast {
                slot.complition = {
                    self.spinningEnded()
                }
            }
        }
    }
    
    private func spinningEnded() {
//        slotBrain.playMostFrequent()
        let coef = slotBrain.checkAllLines()
        complition?(coef)
    }
    
    func startSpinning(complition: ((Int) -> Void)?) {
        self.complition = complition
        
        let timeStep: TimeInterval = 0.2
        
        for slotTuple in slots.enumerated() {
            let wait: TimeInterval = Double(slotTuple.offset) * timeStep
            self.run(.wait(forDuration: wait)) {
                slotTuple.element.start()
            }
        }
    }
    
    func presentYouWin(score: Int) {
        if score == 0 {
            return
        }
        
        let omg = SKLabelNode(text: "+\(score)")
        omg.fontColor = .white
        omg.fontSize = 128
        self.addChild(omg)

        let appear = SKAction.group([SKAction.scale(to: 0.5, duration: 0.25), SKAction.fadeIn(withDuration: 0.25)])
        let disappear = SKAction.group([SKAction.scale(to: 1, duration: 0.25), SKAction.fadeOut(withDuration: 0.25)])
        let sequence = SKAction.sequence([appear, SKAction.wait(forDuration: 0.25), disappear])
        omg.run(sequence)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
