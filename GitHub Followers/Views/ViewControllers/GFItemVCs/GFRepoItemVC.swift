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
    
    //MARK: - Properties
    weak var delegate: GFRepoItemVCDelegate?
    
    //MARK: - VC Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVCItems()
    }
    
    
    //MARK: - VC Methods
    override func didTapOnActionButton() {
        delegate?.didTapGetProfile(with: user)
    }
    
    
    private func configureVCItems() {
        itemInfoViewOne.set(itemInfoType: .repo, count: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, count: user.publicGists)
        actionButton.set(background: .systemPurple, title: "GitHub Profile")
    }
}
