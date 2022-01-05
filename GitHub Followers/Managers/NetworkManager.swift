//
//  NetworkManager.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 02/11/2021.
//

import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        getData(endPoint: endPoint, completion: completion)
    }
    
    
    func getUserInfo(for username: String, completion: @escaping (Result<User, ErrorMessage>) -> Void) {
        let endPoint = baseURL + "\(username)"
        getData(endPoint: endPoint, completion: completion)
    }
    
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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(T.self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
