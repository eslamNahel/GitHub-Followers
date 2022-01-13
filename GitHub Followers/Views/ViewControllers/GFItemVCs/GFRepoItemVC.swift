//
//  GFRepoItemVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 13/01/2022.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVCItems()
    }
    
    
    private func configureVCItems() {
        itemInfoViewOne.set(itemInfoType: .repo, count: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, count: user.publicGists)
        actionButton.set(background: .systemPurple, title: "GitHub Profile")
    }
}
