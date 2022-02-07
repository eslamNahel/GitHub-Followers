//
//  FavoriteCell.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 27/01/2022.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    //MARK: - Components & Properties
    static let reuseID      = "favoriteCell"
    let avatarImageView     = GFImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    
    //MARK: - Init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        addAvatarImageView()
        addUsernameLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View Data Methods
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    
    //MARK: - Cell UI setup methods
    private func addAvatarImageView() {
        addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor)
        ])
    }
    
    
    private func addUsernameLabel() {
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
