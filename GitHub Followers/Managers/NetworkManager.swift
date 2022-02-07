//
//  NetworkManager.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 02/11/2021.
//

import UIKit

class NetworkManager {
    
    //MARK: - Properties
    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    private let cache   = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    //MARK: - Public Methods
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        getData(endPoint: endPoint, completion: completion)
    }
    
    
    func getUserInfo(for username: String, completion: @escaping (Result<User, ErrorMessage>) -> Void) {
        let endPoint = baseURL + "\(username)"
        getData(endPoint: endPoint, completion: completion)
    }
    
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                      completion(nil)
                      return
                  }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
    
    
    //MARK: - Private Methods
    private func getData<T: Codable>(endPoint: String, completion: @escaping (Result<T, ErrorMessage>) -> Void) {
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder                     = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let data                        = try decoder.decode(T.self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
