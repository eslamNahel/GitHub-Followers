//
//  UserInfoVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 05/01/2022.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: userName) { results in
            switch results {
            case .success(let userInfo):
                print(userInfo)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something baaad happened!", message: error.rawValue, actionTitle: "Alrighty")
            }
        }
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
