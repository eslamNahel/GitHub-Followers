//
//  GFSecondaryTitleLabel.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 10/01/2022.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View UI Methods
    private func configure() {
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail

        translatesAutoresizingMaskIntoConstraints = false
    }

}
