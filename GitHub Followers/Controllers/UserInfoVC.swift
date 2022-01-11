//
//  UserInfoVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 05/01/2022.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton

        addHeaderView()
        
        NetworkManager.shared.getUserInfo(for: userName) { results in
            switch results {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self.addChildToContainer(childVC: GFUserInfoHeaderVC(user: userInfo), to: self.headerView)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something baaad happened!", message: error.rawValue, actionTitle: "Alrighty")
            }
        }
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    private func addChildToContainer(childVC: UIViewController, to containerForChild: UIView) {
        addChild(childVC)
        containerForChild.addSubview(childVC.view)
        childVC.view.frame = containerForChild.bounds
        childVC.didMove(toParent: self)
    }
    
    
    private func addHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }

}
