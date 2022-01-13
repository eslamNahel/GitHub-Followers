//
//  UserInfoVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 05/01/2022.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView                  = UIView()
    let itemViewOne                 = UIView()
    let itemViewTwo                 = UIView()
    let constraintPadding: CGFloat  = 20
    
    var userName: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addHeaderView()
        addItemViewOne()
        addItemViewTwo()
        getUserData()
    }
    
    
    private func getUserData() {
        NetworkManager.shared.getUserInfo(for: userName) { results in
            switch results {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self.addChildToContainer(childVC: GFUserInfoHeaderVC(user: userInfo), to: self.headerView)
                    self.addChildToContainer(childVC: GFRepoItemVC(user: userInfo), to: self.itemViewOne)
                    self.addChildToContainer(childVC: GFFollowerItemVC(user: userInfo), to: self.itemViewTwo)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something baaad happened!", message: error.rawValue, actionTitle: "Alrighty")
            }
        }
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
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
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraintPadding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraintPadding),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    
    private func addItemViewOne() {
        view.addSubview(itemViewOne)
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: constraintPadding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraintPadding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraintPadding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    
    private func addItemViewTwo() {
        view.addSubview(itemViewTwo)
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: constraintPadding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraintPadding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraintPadding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
}
