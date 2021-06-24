//
//  PlaylistTableViewCell.swift
//  Player
//
//  Created by Дмитрий Дудкин on 24.06.2021.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {

//    MARK: - Properties
    static let identifier = "PlaylistTableViewCell"
    var song: Song?
    
    let cover = UIImageView()
    let titleLabel = UILabel()
    let artistLabel = UILabel()
    
//    MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Configuration
    
    func configurate(with song: Song) {
        self.song = song
                
        cover.image = UIImage(named: song.cover)
        titleLabel.text = song.title
        artistLabel.text = song.artist
    }
    
    private func setupLayout() {
        cover.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cover)
        
        cover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        cover.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        cover.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        let titleStack = UIStackView(arrangedSubviews: [titleLabel, artistLabel])
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        titleStack.axis = .vertical
        titleStack.spacing = 10
        contentView.addSubview(titleStack)
        
        titleStack.leftAnchor.constraint(equalTo: cover.rightAnchor, constant: 10).isActive = true
    }
}
