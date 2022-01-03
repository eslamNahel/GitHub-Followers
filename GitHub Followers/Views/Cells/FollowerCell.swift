//
//  FollowerCell.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 03/11/2021.
//

import Foundation
import UIKit

class FollowerCell: UICollectionViewCell {
    
    //MARK: - Components
    static let resuseID     = "followerCell"
    let avatarImageView     = GFImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Component public methods
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadAvatarImage(from: follower.avatarUrl)
    }
    
    
    //MARK: - UI configuration method
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
