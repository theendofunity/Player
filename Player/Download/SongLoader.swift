//
//  SongLoader.swift
//  Player
//
//  Created by Дмитрий Дудкин on 24.06.2021.
//

import Foundation
import MediaPlayer

class SongLoader {
    static let shared = SongLoader()
    
    private init() {}
    
    var songs = [Song]()
    
    func load(completion: @escaping ([Song]) -> Void) {
        if !songs.isEmpty {
            completion(songs)
            return
        }
        
        MPMediaLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                let query = MPMediaQuery.songs()
                if let items = query.items
                {
                    for item in items {
                        guard let song = Song(from: item) else { continue }
                        self.songs.append(song)
                        print(song)
                    }
                    completion(self.songs)
                }
            default:
                break
            }
        }
    }
}
