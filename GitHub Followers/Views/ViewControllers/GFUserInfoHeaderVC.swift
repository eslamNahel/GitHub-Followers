//
//  GFUserInfoVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 10/01/2022.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView   = GFImageView(frame: .zero)
    let usernameLabel     = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel         = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel     = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel          = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAvatarImage()
        addUsernameLabel()
        addNameLabel()
        addLocationImage()
        addLocationName()
        addBioLabel()
        
        configureUIElements()
    }
    
    
    private func configureUIElements() {
        avatarImageView.downloadAvatarImage(from: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "Not Available"
        bioLabel.text = user.bio ?? "Not Available"
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }

    
    private func addAvatarImage() {
        view.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    
    private func addUsernameLabel() {
        view.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 0),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    
    private func addNameLabel() {
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    private func addLocationImage() {
        view.addSubview(locationImageView)
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 0),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalTo: locationImageView.widthAnchor)
        ])
    }
    
    
    private func addLocationName() {
        view.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    private func addBioLabel() {
        view.addSubview(bioLabel)
        bioLabel.numberOfLines = 3
        bioLabel.lineBreakMode = .byTruncatingTail
        bioLabel.minimumScaleFactor = 0.9
        
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: 0),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
