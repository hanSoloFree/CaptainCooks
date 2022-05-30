//
//  AVPlayerManager.swift
//  playingWithAVPlayer
//
//  Created by Vsevolod Shelaiev on 25.08.2021.
//
//
import UIKit
import AVFoundation

public let backgroundPlayer = AVPlayerManager.shared
public final class AVPlayerManager: NSObject {
    
    static let shared = AVPlayerManager()
    
    var player: AVAudioPlayer? = nil
    
    private override init() {
        guard let url = Bundle.main.path(forResource: "JWL_AmbiGeneral", ofType: "wav") else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
            player?.prepareToPlay()
            player?.numberOfLoops = -1
        } catch {
            return
        }
    }
    
    func cheer() { player?.play() }
    func stop() { player?.stop()}
}

public let spinPlayer = AVSpinPlayerManager.shared

public final class AVSpinPlayerManager: NSObject {
    static let shared = AVSpinPlayerManager()
    
    var player: AVAudioPlayer? = nil
    
    private override init() {
        guard let url = Bundle.main.path(forResource: "spinSound", ofType: "wav") else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
            player?.prepareToPlay()
        } catch {
            return
        }
        
        
    }
    
    func cheer() { player?.play()}
    
    func stop() {
        player?.pause()
        player?.play(atTime: .zero)
    }
}
