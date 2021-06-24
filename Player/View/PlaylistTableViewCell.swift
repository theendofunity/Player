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
                
        cover.image = song.cover
        titleLabel.text = song.title
        artistLabel.text = song.artist
    }
    
    private func setupLayout() {
        
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false

        let titleStack = UIStackView(arrangedSubviews: [titleLabel, artistLabel, ])
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        titleStack.axis = .vertical
        titleStack.alignment = .top
        titleStack.distribution = .fillProportionally
        titleStack.spacing = 20
        
        let stackView = UIStackView(arrangedSubviews: [cover, titleStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        contentView.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
    }
}
