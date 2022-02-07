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
    
    //MARK: - Properties
    weak var delegate: GFFollowerItemVCDelegate?
    
    
    //MARK: - VC Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVCItems()
    }
    
    
    //MARK: - VC Methods
    override func didTapOnActionButton() {
        delegate?.didTapGetFollowers(with: user)
    }
    
    
    private func configureVCItems() {
        itemInfoViewOne.set(itemInfoType: .followers, count: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, count: user.following)
        actionButton.set(background: .systemGreen, title: "Get Followers")
    }
}
