//
//  FollowersListVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 02/11/2021.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(with username: String)
}


class FollowersListVC: UIViewController {
    
    //MARK: - Component & Properties
    enum Section {
        case main
    }
    
    var userName: String!
    var followers           = [Follower]()
    var filteredFollowers   = [Follower]()
    var page                = 1
    var hasMoreFollowers    = true
    var isSearching         = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    //MARK: - VC lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: userName, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    //MARK: - Networking methods
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] results in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch results {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers! Go and follow them 😉"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.updateData(on: self.followers)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Sth baaaad happened", message: error.rawValue, actionTitle: "Alrighty")
            }
        }
    }
    
    
    //MARK: - VC functionality methods
    @objc func addButtonTapped() {
        self.showLoadingView()
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] results in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch results {
            case .success(let favoriteInfo):
                let favorite = Follower(login: favoriteInfo.login, avatarUrl: favoriteInfo.avatarUrl)
                PersistenceManager.shared.updateFavoritesList(with: favorite, actionType: .add) { [weak self] gfError in
                    if let gfError = gfError {
                        self?.presentAlertOnMainThread(title: "Something went wrong!", message: gfError.rawValue, actionTitle: "Oki")
                        return
                    }
                    self?.presentAlertOnMainThread(title: "Success!", message: "You have saved this user to favorites 🥳", actionTitle: "Hooraay")
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, actionTitle: "Oki")
            }
        }
    }
    
    
    //MARK: - Collection View data source methods
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    //MARK: - UI Configuration Methods
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayoutColumns(in: view))
        view.addSubview(collectionView)
        collectionView.delegate         = self
        collectionView.backgroundColor  = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    private func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.delegate                     = self
        searchController.searchBar.placeholder                  = "Search for users"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.hidesSearchBarWhenScrolling              = false
        navigationItem.searchController                         = searchController
    }
}


//MARK: - VC extensions
extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y + 170
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offSetY >= contentHeight - height {
            guard hasMoreFollowers else {
                return
            }
            self.page += 1
            self.getFollowers(username: userName, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let followersArray = isSearching ? filteredFollowers : followers
        let follower = followersArray[indexPath.item]
        
        let userInfoVC = UserInfoVC()
        userInfoVC.delegate = self
        userInfoVC.userName = follower.login
        let navVC = UINavigationController(rootViewController: userInfoVC)
        present(navVC, animated: true)
    }
}


extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            self.updateData(on: self.followers)
            return
        }
        isSearching = true
        filteredFollowers = followers.filter {
            $0.login.lowercased().contains(filter.lowercased())
        }
        
        self.updateData(on: self.filteredFollowers)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.updateData(on: self.followers)
    }
}


extension FollowersListVC: FollowerListVCDelegate {
    
    func didRequestFollowers(with username: String) {
        self.userName = username
        title = username
        self.page = 1
        self.followers.removeAll()
        self.filteredFollowers.removeAll()
        collectionView.scrollsToTop = true
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        if isSearching {
            navigationItem.searchController?.searchBar.text = ""
            navigationItem.searchController?.isActive = false
            navigationItem.searchController?.dismiss(animated: false)
            isSearching = false
        }
        getFollowers(username: username, page: page)
    }
}

