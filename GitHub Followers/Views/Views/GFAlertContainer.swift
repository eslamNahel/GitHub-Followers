//
//  GFAlertContainer.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 29/01/2022.
//

import UIKit

class GFAlertContainer: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor       = .systemBackground
        layer.cornerRadius    = 16
        layer.borderColor     = UIColor.white.cgColor
        layer.borderWidth     = 2
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
