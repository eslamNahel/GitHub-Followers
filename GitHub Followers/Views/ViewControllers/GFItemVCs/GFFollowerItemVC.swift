//
//  GFFollowerItemVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 13/01/2022.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(with user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerItemVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVCItems()
    }
    
    override func didTapOnActionButton() {
        delegate?.didTapGetFollowers(with: user)
    }
    
    
    private func configureVCItems() {
        itemInfoViewOne.set(itemInfoType: .followers, count: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, count: user.following)
        actionButton.set(background: .systemGreen, title: "Get Followers")
    }
}
