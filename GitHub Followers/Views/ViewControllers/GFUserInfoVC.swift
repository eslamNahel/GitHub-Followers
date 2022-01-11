//
//  GFUserInfoVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 10/01/2022.
//

import UIKit

class GFUserInfoVC: UIViewController {
    
    let avatarImageView   = GFImageView(frame: .zero)
    let usernameLabel     = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel         = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel     = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel          = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
