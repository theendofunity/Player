//
//  Player.swift
//  Player
//
//  Created by Дмитрий Дудкин on 25.06.2021.
//

import Foundation
import AVFoundation

class Player {
//    MARK - Properties
    
    var player: AVAudioPlayer?
    var timeObserverToken: Any?

//    MARK: - Playing control
    
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
    
//    MARK: - States
    
    func isPlaying() -> Bool {
        guard let player = player else {
            return false
        }
        return player.isPlaying
    }
        
    func currentTime() -> TimeInterval {
        guard let player = player else {
             return TimeInterval(0)
        }
        
        if player.isPlaying {
            return player.currentTime
        } else {
            return TimeInterval(0)
        }
    }
    
    func songDuration() -> TimeInterval {
        guard let player = player else {
             return TimeInterval(0)
        }
        return player.duration
    }
}
