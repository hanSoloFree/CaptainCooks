//
//  SlotBrain.swift
//  slot
//
//  Created by 1 on 23.11.2021.
//

import SpriteKit

struct SMBrain {
    
    let slotMachine: SM
    
    private let minCountToWin: Int = 3
    
    private func nodesForLine(line: SMLine) -> [SMItemNode] {
        var items = [SMItemNode]()
        line.points.forEach {
            let soloSlot = slotMachine.slots[$0.col]
            let item = soloSlot.visibleItems[$0.row]
            items.append(item)
        }
        return items
    }
    
    // находим самый частый символ и возвращаем его имя есть он встречается больше чем 2 раза
    private func nameOfMostFrequentItem() -> (count: Int, name: String)? {
        let itemsNames = slotMachine.allItems.map { $0.name ?? "" } // надо б шото придумать с этим ??
        var counts = [String: Int]()

        itemsNames.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }

        if let mostFrequent = counts.max(by: {$0.1 < $1.1}) {
            print("\(mostFrequent.key) occurs \(mostFrequent.value) times")
            return (count: mostFrequent.value, name: mostFrequent.key)
        } else {
            return nil
        }
    }
    
    func playMostFrequent() {
        guard let popularName = nameOfMostFrequentItem() else { return }
        guard popularName.count >= minCountToWin else { return }

        slotMachine.allItems.forEach {
            if $0.name == popularName.name {
                $0.fire()
            }
        }
    }
    
    func showAllLines() {
        var acions = [SKAction]()
        let lines = SMLine.lines35
        for line in lines {
            let action = SKAction.sequence([
                .run { self.play(line: line) },
                .wait(forDuration: 1.2),
            ])
            acions.append(action)
        }
        self.slotMachine.run(.sequence(acions))
    }
    
    func checkAllLines() -> Int {
        var allLines: [SMLine] = [SMLine]()
        allLines = SMLine.lines35
        let macheddLines: [SMLine] = machedLines(from: allLines)
                
        var acions = [SKAction]()
        for line in macheddLines {
            let action1: SKAction = SKAction.run { self.play(line: line)}
            let action2: SKAction = SKAction.wait(forDuration: 1.0)
            let action = SKAction.sequence([
                action1,action2
            ])
            acions.append(action)
            
        }
        self.slotMachine.run(.sequence(acions))
        
        
        let coef = (macheddLines.count + 1) * macheddLines.count
//        slotMachine.presentYouWin(score: slotMachine.bet * coef)
        return coef
    }
    
//    func countWin() -> Int? {
//        guard let popular = nameOfMostFrequentItem() else { return nil }
//        guard popular.count >= minCountToWin else { return nil }
//        
//        let bet = slotMachine.bet
//        return bet * popular.count
//    }
    
    private func machedLines(from lines: [SMLine]) -> [SMLine] {
        var winLines: [SMLine] = [SMLine]()
        for line in lines {
            var items: [SMItemNode] = [SMItemNode]()
            items = nodesForLine(line: line)
            var itemsNames = [String]()
            itemsNames = items.map { $0.name ?? "" } // // надо б шото придумать с этим ??
            if itemsNames[0] == itemsNames[1] && itemsNames[1] == itemsNames[2] {
                winLines.append(line)
            }
        }
            return winLines
    }
    
    private func pathForLine(_ line: SMLine) -> UIBezierPath {
        let step = slotMachine.rowWidth
        
        let xOffset: CGFloat = -step * 2.0
        let yOffset: CGFloat = -step * 1.0
        
        let path = UIBezierPath()
        let firstX = xOffset - step / 2
        let firstY = CGFloat(line.points[0].row) * step + yOffset
        path.move(to: CGPoint(x: firstX, y: -firstY))
        
        for point in line.points {
            let x: CGFloat = CGFloat(point.col) * step + xOffset
            let y: CGFloat = CGFloat(point.row) * step + yOffset
            path.addLine(to: CGPoint(x: x, y: -y))
        }
        let lastY = CGFloat(line.points[4].row) * step + yOffset
        let lastX = step * 5.0
        path.addLine(to: CGPoint(x: lastX, y: -lastY))
        
        return path
    }
    
    private func drowLine(_ line: SMLine) {
        let path = pathForLine(line)
        drowPath(path)
    }
    
    private func drowPath(_ path: UIBezierPath) {
        let part = SKEmitterNode(fileNamed: "spark")!
        part.targetNode = slotMachine
        part.zPosition = 100
        slotMachine.addChild(part)
        
        let move = SKAction.follow(path.cgPath, duration: 1)
        part.run(move)
    }
    
    private func play(line: SMLine) {
        let allItems = nodesForLine(line: line)
        let firstItemName = allItems[0].name
        
        var itemsToPlay = [SMItemNode]()
        for item in allItems {
            if item.name == firstItemName {
                itemsToPlay.append(item)
            } else {
                break
            }
        }
        
        var acions = [SKAction]()
        for item in itemsToPlay {
            let action = SKAction.sequence([
                .run { item.fire() },
                .wait(forDuration: 0.1),
            ])
            acions.append(action)
        }
        self.slotMachine.run(.sequence(acions))
        
        drowLine(line)
    }
    
}
