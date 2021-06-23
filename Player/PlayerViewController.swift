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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }


    private func setupLayout() {
        view.backgroundColor = .white
        
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.image = UIImage(named: "coverPlaceholder")
        view.addSubview(cover)
        
        cover.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        cover.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        cover.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
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
        titleStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
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
        
        view.addSubview(playlist)
        
        
        playlist.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 20).isActive = true
        playlist.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
}

