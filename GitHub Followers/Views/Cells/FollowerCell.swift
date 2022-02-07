//
//  FollowerCell.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 03/11/2021.
//

import Foundation
import UIKit

class FollowerCell: UICollectionViewCell {
    
    //MARK: - Components & Properties
    static let reuseID              = "followerCell"
    let avatarImageView             = GFImageView(frame: .zero)
    let usernameLabel               = GFTitleLabel(textAlignment: .center, fontSize: 16)
    private let padding: CGFloat    = 8
    
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAvatarImageView()
        addUsernameLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View Data Methods
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        NetworkManager.shared.downloadImage(from: follower.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    
    //MARK: - UI configuration method
    private func addAvatarImageView() {
        addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    
    private func addUsernameLabel() {
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
