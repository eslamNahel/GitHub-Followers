//
//  FavoritesVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 01/11/2021.
//

import UIKit

class FavoritesVC: UIViewController {
    
    //MARK: - Components & Properties
    let tableView = UITableView()
    var favorites = [Follower]()
    
    
    //MARK: - VC Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    //MARK: - VC Networking methods
    private func getFavorites() {
        PersistenceManager.shared.getFavorites { [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let favorites):
                guard !favorites.isEmpty else {
                    self.showEmptyStateView(with: "Hey! you have no favorites, add one now! 😉", in: self.view)
                    return
                }
                self.favorites = favorites
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, actionTitle: "Ok")
            }
        }
    }
    
    
    
    //MARK: - UI Configuration methods
    private func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
}


//MARK: - VC extensions
extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as? FavoriteCell else {
            fatalError("Couldn't dequeue cell")
        }
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let favorite = favorites[indexPath.row]
        let followerListVC = FollowersListVC(username: favorite.login)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        let favoriteToDelete = favorites[indexPath.row]
        self.favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.shared.updateFavoritesList(with: favoriteToDelete, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                if favorites.isEmpty {
                    self.getFavorites()
                }
                
                return
            }
            
            self.presentAlertOnMainThread(title: "Unable to remove user", message: error.rawValue, actionTitle: "Ok")
        }
    }
}
