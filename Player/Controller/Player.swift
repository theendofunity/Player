//
//  Player.swift
//  Player
//
//  Created by Дмитрий Дудкин on 25.06.2021.
//

import Foundation
import AVFoundation

class Player {
    var player: AVAudioPlayer?
    
    func playAudio(with url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            
            guard let player = player else {
                print("Could not create player")
                return
            }
            player.play()
            
        } catch (let error){
            print(error.localizedDescription)
        }
    }
    
    
    func isPlaying() -> Bool {
        guard let player = player else {
            return false
        }
        return player.isPlaying
    }
    
    func playPause() {
        guard let player = player else {
            print("Player is nil")
            return
        }
        
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
}
