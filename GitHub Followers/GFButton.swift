//
//  GFButton.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 01/11/2021.
//

import UIKit

class GFButton: UIButton {
    
    //MARK: - initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius      = 10
        titleLabel?.textColor   = .white
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}
