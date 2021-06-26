//
//  Song.swift
//  Player
//
//  Created by Дмитрий Дудкин on 24.06.2021.
//

import Foundation
import MediaPlayer

struct Song {
    let title: String
    let artist: String
    let album:  String
    let duration: TimeInterval
    let cover: UIImage?
    let url: URL
    
    init?(from mediaItem: MPMediaItem) {
        guard let title = mediaItem.title,
              let artist = mediaItem.artist,
              let album = mediaItem.albumTitle,
              let cover = mediaItem.artwork,
              let url = mediaItem.assetURL
        else { return nil }
        
        self.title = title
        self.artist = artist
        self.album = album
        self.duration = mediaItem.playbackDuration
        self.url = url
        self.cover = cover.image(at: CGSize(width: 200, height: 200))
    }
}
