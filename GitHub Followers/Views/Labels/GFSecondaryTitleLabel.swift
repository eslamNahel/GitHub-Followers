//
//  GFSecondaryTitleLabel.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 10/01/2022.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail

        translatesAutoresizingMaskIntoConstraints = false
    }

}
