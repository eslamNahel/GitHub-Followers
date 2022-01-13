//
//  GFItemInfoView.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 13/01/2022.
//

import UIKit

class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSymbolImage()
        addTitleLabel()
        addCountLabel()
    }
    
    
    func set(itemInfoType: ItemInfoType, count: Int) {
        switch itemInfoType {
        case .repo:
            symbolImageView.image = UIImage(systemName: SFSymbols.repo)
            titleLabel.text       = "Public repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text       = "Public gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text       = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text       = "Following"
        }
        
        countLabel.text = String(count)
    }

    
    private func addSymbolImage() {
        addSubview(symbolImageView)
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalTo: symbolImageView.widthAnchor)
        ])
    }
    
    
    private func addTitleLabel() {
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    private func addCountLabel() {
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
