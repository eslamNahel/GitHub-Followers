//
//  UserInfoVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 05/01/2022.
//


import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGetProfile(with user: User)
    func didTapGetFollowers(with user: User)
}

class UserInfoVC: UIViewController {
    
    //MARK: - Components & Properties
    let headerView                  = UIView()
    let itemViewOne                 = UIView()
    let itemViewTwo                 = UIView()
    let dateLabel                   = GFBodyLabel(textAlignment: .center)
    
    let constraintPadding: CGFloat  = 20
    var userName: String!
    weak var delegate: FollowerListVCDelegate?

    
    //MARK: - VC Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addHeaderView()
        addItemViewOne()
        addItemViewTwo()
        addDateLabel()
        getUserData()
    }
    
    
    //MARK: - VC Networking methods
    private func getUserData() {
        NetworkManager.shared.getUserInfo(for: userName) { results in
            switch results {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self.configureVCItems(with: userInfo)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something baaad happened!", message: error.rawValue, actionTitle: "Alrighty")
            }
        }
    }
    
    
    //MARK: - VC Additional Methods
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    private func configureVCItems(with userInfo: User) {
        let repoView = GFRepoItemVC(user: userInfo)
        repoView.delegate = self
        
        let followersView = GFFollowerItemVC(user: userInfo)
        followersView.delegate = self
        
        self.addChildToContainer(childVC: GFUserInfoHeaderVC(user: userInfo), to: self.headerView)
        self.addChildToContainer(childVC: repoView, to: self.itemViewOne)
        self.addChildToContainer(childVC: followersView, to: self.itemViewTwo)
        self.dateLabel.text = "On GitHub since: \(userInfo.createdAt.convertToString())"
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
    
    
    //MARK: - UI Configuration methods
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
    
    
    private func addDateLabel() {
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: constraintPadding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraintPadding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraintPadding),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


//MARK: - VC Extensions
extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGetProfile(with user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertOnMainThread(title: "Invalid URL!", message: "The url linked to this user is invalid.", actionTitle: "oki")
            return
        }
        presentSafariVC(with: url)
    }
    
    
    func didTapGetFollowers(with user: User) {
        guard user.followers > 0 else {
            presentAlertOnMainThread(title: "No Followers", message: "This user has no followers ☹️", actionTitle: "oh ok")
            return
        }
        delegate?.didRequestFollowers(with: user.login)
        dismissVC()
    }
}
