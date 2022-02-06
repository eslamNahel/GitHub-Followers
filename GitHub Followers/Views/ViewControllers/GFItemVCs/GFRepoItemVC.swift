//
//  GFRepoItemVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 13/01/2022.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGetProfile(with user: User)
}

class GFRepoItemVC: GFItemInfoVC {
    
    weak var delegate: GFRepoItemVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVCItems()
    }
    
    
    override func didTapOnActionButton() {
        delegate?.didTapGetProfile(with: user)
    }
    
    
    private func configureVCItems() {
        itemInfoViewOne.set(itemInfoType: .repo, count: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, count: user.publicGists)
        actionButton.set(background: .systemPurple, title: "GitHub Profile")
    }
}
