//
//  GFImageView.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 03/11/2021.
//

import UIKit


class GFImageView: UIImageView {
    
    //MARK: - Components & Properties
    let placeHolderImage = UIImage(named: "avatar-placeholder")
    let cache           = NetworkManager.shared.cache
    
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View UI Methods
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeHolderImage
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    //MARK: - View Data Methods
    func downloadAvatarImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                self.image = image
            }
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
