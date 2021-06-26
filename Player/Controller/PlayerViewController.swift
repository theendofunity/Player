//
//  ViewController.swift
//  Player
//
//  Created by Дмитрий Дудкин on 23.06.2021.
//

import UIKit

class PlayerViewController: UIViewController {

//    MARK: - Properties
    let cover = UIImageView()
    let titleLabel = UILabel()
    let artistLabel = UILabel()
    let albumLabel = UILabel()
    
    let currentTime = UILabel()
    let totalTime = UILabel()
    let timeline = UISlider()
    
    let backward = UIButton()
    let play = UIButton()
    let forward = UIButton()
    
    let playlist = UIButton()
    
    var songs = [Song]()
    var currentSongNumber = 0
    let player = Player()
    
//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

//    MARK: - Songs loading
    
    func configurateWith(songNumber: Int) {
        
        if songNumber > songs.count {
            return
        }
        
        currentSongNumber = songNumber
        
        let song = songs[currentSongNumber]
        
        titleLabel.text = song.title
        artistLabel.text = song.artist
        albumLabel.text = song.album
        cover.image = song.cover
        
        totalTime.text = song.duration.stringFormatted()
    }
//    MARK: - UI setup
    
    private func setupLayout() {
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.image = UIImage(named: "coverPlaceholder")
        view.addSubview(cover)
        
        cover.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        cover.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        cover.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        cover.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        titleLabel.text = "Title"
        albumLabel.text = "Album"
        artistLabel.text = "Artist"
        let titleStack = UIStackView(arrangedSubviews: [titleLabel, artistLabel, albumLabel])
        titleStack.axis = .vertical
        titleStack.alignment = .leading
        titleStack.spacing = 20
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleStack)
        
        titleStack.topAnchor.constraint(equalTo: cover.bottomAnchor, constant: 20).isActive = true
        titleStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        currentTime.text = "0:00"
        totalTime.text = "0:00"
        timeline.isUserInteractionEnabled = false
        let timelineStack = UIStackView(arrangedSubviews: [currentTime, timeline, totalTime])
        timelineStack.translatesAutoresizingMaskIntoConstraints = false
        timelineStack.axis = .horizontal
        timelineStack.spacing = 10
        
        view.addSubview(timelineStack)
        
        timelineStack.topAnchor.constraint(equalTo: titleStack.bottomAnchor, constant: 20).isActive = true
        timelineStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        timelineStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true

        let configuration = UIImage.SymbolConfiguration (pointSize: 50.0)
        let backwardImage = UIImage(systemName: "backward.fill", withConfiguration: configuration)
        let forwardImage = UIImage(systemName: "forward.fill", withConfiguration: configuration)
        let playImage = UIImage(systemName: "play.fill", withConfiguration: configuration)

        backward.setImage(backwardImage, for: .normal)
        backward.translatesAutoresizingMaskIntoConstraints = false
        play.setImage(playImage, for: .normal)
        play.translatesAutoresizingMaskIntoConstraints = false
        forward.setImage(forwardImage, for: .normal)
        forward.translatesAutoresizingMaskIntoConstraints = false

        play.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        backward.addTarget(self, action: #selector(previousSong), for: .touchUpInside)
        forward.addTarget(self, action: #selector(nextSong), for: .touchUpInside)
        
        let buttonsStack = UIStackView(arrangedSubviews: [backward, play, forward])
        buttonsStack.axis = .horizontal
        buttonsStack.alignment = .fill
        buttonsStack.spacing = 20
        buttonsStack.distribution = .fill
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonsStack)
        
        buttonsStack.topAnchor.constraint(equalTo: timelineStack.bottomAnchor, constant: 20).isActive = true
        buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let playlistConfiguration = UIImage.SymbolConfiguration (pointSize: 20.0)
        let playlistImage = UIImage(systemName: "text.insert", withConfiguration: playlistConfiguration)
        playlist.setImage(playlistImage, for: .normal)
        playlist.translatesAutoresizingMaskIntoConstraints = false
        playlist.addTarget(self, action: #selector(openPlaylist), for: .touchUpInside)
        
        view.addSubview(playlist)
        
        playlist.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 20).isActive = true
        playlist.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    @objc private func openPlaylist() {
        let playlistViewController = PlaylistTableViewController()
        playlistViewController.completion = { [weak self] songs, currentNumber in
            self?.songs = songs
            self?.configurateWith(songNumber: currentNumber)
            self?.playAudio()
        }
        
        self.navigationController?.pushViewController(playlistViewController, animated: true)
    }
    
    private func setupPlayPauseButtonImage() {
        let isPlaying = player.isPlaying()
        
        let configuration = UIImage.SymbolConfiguration (pointSize: 50.0)
        let image: UIImage?
        
        if isPlaying {
            image = UIImage(systemName: "pause.fill", withConfiguration: configuration)
        } else {
            image = UIImage(systemName: "play.fill", withConfiguration: configuration)
        }
        play.setImage(image, for: .normal)
    }
    
    @objc private func playPause() {
        player.playPause()
        setupPlayPauseButtonImage()
    }
    
    @objc private func nextSong() {
        if songs.isEmpty {
            return
        }
        if currentSongNumber == songs.count - 1 {
            currentSongNumber = 0
        } else {
            currentSongNumber += 1
        }
        
        configurateWith(songNumber: currentSongNumber)
        playAudio()
    }
    
    @objc private func previousSong() {
        if songs.isEmpty {
            return
        }
        if currentSongNumber == 0 {
            currentSongNumber = songs.count - 1
        } else {
            currentSongNumber -= 1
        }
        
        configurateWith(songNumber: currentSongNumber)
        playAudio()
    }
    
    private func playAudio() {
        let song = songs[currentSongNumber]
        player.playAudio(with: song.url)
        setupPlayPauseButtonImage()
    }
}

