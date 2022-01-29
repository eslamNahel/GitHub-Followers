//
//  GFButton.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 01/11/2021.
//

import UIKit

class GFButton: UIButton {
    
    //MARK: - Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View Methods
    func set(background: UIColor, title: String) {
        self.backgroundColor = background
        setTitle(title, for: .normal)
    }
    
    
    private func configure() {
        layer.cornerRadius      = 10
        titleLabel?.textColor   = .white
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
