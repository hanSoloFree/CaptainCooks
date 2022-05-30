//
//  SMScene.swift
//  JackotCity
//
//  Created by Vsevolod Shelaiev on 08.12.2021.
//

import Foundation
import SpriteKit

class SMScene: SKScene, SpinMachineDelegate  {
    
    func startSpinning(completion: @escaping (_ win: Int) ->() ) {
        slot.startSpinning { win in
//            print(win)
            completion(win)
        }
    }
    
    var slot: SM!
    var slotBrain: SMBrain!
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.backgroundColor = .clear
        let verticalSpasing: CGFloat = -50
        let horizontalSpacing: CGFloat = -50
        slot = SM(size: .init(width: frame.width - verticalSpasing * 2, height: frame.height - horizontalSpacing * 2 ))
        slot.bet = 100
        
        self.addChild(slot)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
