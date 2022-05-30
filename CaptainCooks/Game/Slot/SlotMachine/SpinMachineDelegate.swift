//
//  SpinMachineDelegate.swift
//  LuxurySlots
//
//  Created by Vsevolod Shelaiev on 03.12.2021.
//

import Foundation
import SpriteKit

protocol SpinMachineDelegate {
    func startSpinning(completion: @escaping (_ win: Int) ->())
}
