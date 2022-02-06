//
//  UIHelper.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 10/12/2021.
//

import UIKit

struct UIHelper {
    
    private init() {}
    
    static func createFlowLayoutColumns(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let layout                      = UICollectionViewFlowLayout()
        layout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize                 = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return layout
    }
}
