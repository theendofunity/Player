//
//  PlaylistTableViewController.swift
//  Player
//
//  Created by Дмитрий Дудкин on 24.06.2021.
//

import UIKit

class PlaylistTableViewController: UITableViewController {
//    MARK: - Properties
    var songs = [Song]()
    var completion: (([Song], Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(PlaylistTableViewCell.self, forCellReuseIdentifier: PlaylistTableViewCell.identifier)
        
        SongLoader.shared.load { [weak self] songs in
            self?.songs = songs
            DispatchQueue.main.async     {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier,
                                                       for: indexPath) as? PlaylistTableViewCell
        else { return UITableViewCell() }

        let song = songs[indexPath.row]
        cell.configurate(with: song)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion?(songs, indexPath.row)
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
