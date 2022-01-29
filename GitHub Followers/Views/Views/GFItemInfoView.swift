//
//  GFItemInfoView.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 13/01/2022.
//

import UIKit

class GFItemInfoView: UIView {

    //MARK: - Components & Properties
    let symbolImageView = UIImageView()
    let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSymbolImage()
        addTitleLabel()
        addCountLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View Data Methods
    func set(itemInfoType: ItemInfoType, count: Int) {
        switch itemInfoType {
        case .repo:
            symbolImageView.image = SFSymbolsImages.repo
            titleLabel.text       = "Public repos"
        case .gists:
            symbolImageView.image = SFSymbolsImages.gists
            titleLabel.text       = "Public gists"
        case .followers:
            symbolImageView.image = SFSymbolsImages.followers
            titleLabel.text       = "Followers"
        case .following:
            symbolImageView.image = SFSymbolsImages.following
            titleLabel.text       = "Following"
        }
        
        countLabel.text = String(count)
    }

    
    //MARK: - View UI Methods
    private func addSymbolImage() {
        addSubview(symbolImageView)
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.tintColor = .label
        symbolImageView.contentMode = .scaleAspectFill
        
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
