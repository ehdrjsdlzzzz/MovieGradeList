//
//  CachableImageView.swift
//  MovieGradeList
//
//  Created by 이동건 on 26/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class CachableImageView: UIImageView {
    private var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUsedToLoadImage = urlString
        
        if let cachedImage = ImageCacheService.default.image(key: urlString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch photo", err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            guard let image = UIImage(data: imageData) else { return }
            ImageCacheService.default.save(key: url.absoluteString, value: image)
            DispatchQueue.main.async {
                self.image = image
            }
            }.resume()
    }
}
