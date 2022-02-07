//
//  PersistenceManager.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 26/01/2022.
//

import UIKit

enum FavoritesManagerActionType {
    case add
    case remove
}

class PersistenceManager {
    
    //MARK: - Properties
    static let shared       = PersistenceManager()
    private let defaults    = UserDefaults.standard
    
    private enum Keys { static let favorites = "favorites" }
    
    
    //MARK: - Public Methods
    func updateFavoritesList(with favorite: Follower, actionType: FavoritesManagerActionType, completed: (ErrorMessage?) -> Void) {
        getFavorites { results in
            switch results {
            case .success(var savedFavorites):
                switch actionType {
                case .add:
                    guard !savedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    savedFavorites.append(favorite)
                case .remove:
                    savedFavorites.removeAll { $0.login == favorite.login }
                }
                completed(saveFavorites(favorites: savedFavorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    func getFavorites(completed: (Result<[Follower], ErrorMessage>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.invalidToSaveFavorite))
        }
    }
    
    
    //MARK: - Private Methods
    private func saveFavorites(favorites: [Follower]) -> ErrorMessage? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .invalidToSaveFavorite
        }
    }
    
}
