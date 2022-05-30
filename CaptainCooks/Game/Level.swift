//
//  Level.swift
//  SlotDemo
//
//  Created by Vsevolod Shelaiev on 19.08.2021.
//

import UIKit

class Level {
    static let shared = Level()
    static let maxRateLevel: Float = 50
    
    //level:
    let levelKey = "LEVEL"
    var level: Int {
        get {
            return UserDefaults.standard.integer(forKey: levelKey)
        }
        set {
            guard newValue > 0 else {
                return
            }
            guard newValue > level else {
                return
            }
            UserDefaults.standard.set(newValue, forKey: levelKey)
        }
    }
    //shared level:
    let sharedKey = "SharedKEY"
    var rateLevel: Float {
        get {
            return UserDefaults.standard.float(forKey: sharedKey)
        }
        set {
            guard newValue > 0 else {
                return
            }
            UserDefaults.standard.set(newValue, forKey: sharedKey)
        }
    }
    //coins:
    let coinsKey = "CoinsKey"
    var coinsPool: Int {
        get {
            return UserDefaults.standard.integer(forKey: coinsKey)
        }
        set {
            guard newValue >= 0 else {
                return
            }
            UserDefaults.standard.set(newValue, forKey: coinsKey)
        }
    }
    let bonusKey = "bonusKey"
    
    var dateGetBonus: Date? {
        get {
            return UserDefaults.standard.object(forKey: "bonusDate") as? Date
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "bonusDate")
        }
    }
    
    var getBonus: Bool {
        get {
            return UserDefaults.standard.bool(forKey: bonusKey)
        }
        set {
            UserDefaults.standard.setValue(true, forKey: bonusKey)
        }
    }
    let musicKey = "musicKey"
    
    var musicOn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: musicKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: musicKey)
        }
    }
    
    let progressKey = "progressKey"
    
    var progress: Int {
        get {
            return UserDefaults.standard.integer(forKey: progressKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: progressKey)
        }
    }
    
    let progressLevelKey = "progressLevelKey"
    
    var progressLevel: Int {
        get {
            return UserDefaults.standard.integer(forKey: progressLevelKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: progressLevelKey)
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: [levelKey : 1])
        UserDefaults.standard.register(defaults: [sharedKey: 0])
        UserDefaults.standard.register(defaults: [coinsKey: 10_000_000])
        UserDefaults.standard.register(defaults: [bonusKey: false])
        UserDefaults.standard.register(defaults: [musicKey: false])
        UserDefaults.standard.register(defaults: [progressKey: 0])
        UserDefaults.standard.register(defaults: [progressLevelKey: 1])
    }
}
