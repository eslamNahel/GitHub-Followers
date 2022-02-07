//
//  UserInfoVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 05/01/2022.
//


import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(with username: String)
}

class UserInfoVC: UIViewController {
    
    //MARK: - Components & Properties
    let scrollView                  = UIScrollView()
    let contentView                 = UIView()
    
    let headerView                  = UIView()
    let itemViewOne                 = UIView()
    let itemViewTwo                 = UIView()
    let dateLabel                   = GFBodyLabel(textAlignment: .center)
    
    let constraintPadding: CGFloat  = 20
    var userName: String!
    
    weak var delegate: UserInfoVCDelegate?

    
    //MARK: - VC Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addScrollView()
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
                    self.updateUIWithUserInfo(with: userInfo)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something baaad happened!", message: error.rawValue, actionTitle: "Alrighty")
            }
        }
    }
    
    
    private func updateUIWithUserInfo(with userInfo: User) {
        let repoView            = GFRepoItemVC(user: userInfo)
        repoView.delegate       = self
        
        let followersView       = GFFollowerItemVC(user: userInfo)
        followersView.delegate  = self
        
        self.addChildToContainer(childVC: GFUserInfoHeaderVC(user: userInfo), to: self.headerView)
        self.addChildToContainer(childVC: repoView, to: self.itemViewOne)
        self.addChildToContainer(childVC: followersView, to: self.itemViewTwo)
        self.dateLabel.text = "On GitHub since: \(userInfo.createdAt.convertToString())"
    }
    
    
    //MARK: - VC Additional Methods
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    private func addChildToContainer(childVC: UIViewController, to containerForChild: UIView) {
        addChild(childVC)
        containerForChild.addSubview(childVC.view)
        childVC.view.frame = containerForChild.bounds
        childVC.didMove(toParent: self)
    }
    
    
    //MARK: - UI Configuration methods
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }

        
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 650)
        ])
    }
    
    
    private func addHeaderView() {
        contentView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constraintPadding),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constraintPadding),
            headerView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
    
    
    private func addItemViewOne() {
        contentView.addSubview(itemViewOne)
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: constraintPadding),
            itemViewOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constraintPadding),
            itemViewOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constraintPadding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    
    private func addItemViewTwo() {
        contentView.addSubview(itemViewTwo)
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: constraintPadding),
            itemViewTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constraintPadding),
            itemViewTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constraintPadding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    
    private func addDateLabel() {
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: constraintPadding),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constraintPadding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constraintPadding),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


//MARK: - VC Extensions
extension UserInfoVC: GFFollowerItemVCDelegate, GFRepoItemVCDelegate {
    
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
