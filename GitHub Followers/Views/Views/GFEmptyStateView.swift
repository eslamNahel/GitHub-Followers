//
//  GFEmptyStateView.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 04/01/2022.
//

import UIKit

class GFEmptyStateView: UIView {
    
    //MARK: - Components & Properties
    let messageLabel    = GFTitleLabel(textAlignment: .center, fontSize: 22)
    let logoImageView   = UIImageView()
    var logoImageConstraints: NSLayoutConstraint!

    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        addMessageLabel()
        addLogoImage()
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View UI Methods
    private func addMessageLabel() {
        addSubview(messageLabel)
        
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        
        let messageConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 150 : 200
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -messageConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func addLogoImage() {
        addSubview(logoImageView)
        
        logoImageView.image = AppImages.EmptyStateImage
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoImageConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 50 : 30
        logoImageConstraints = logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoImageConstant)
        logoImageConstraints.isActive = true
        
        let logoImageWidth: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 1.1 : 1.3
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: logoImageWidth),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
        ])
    }
}
