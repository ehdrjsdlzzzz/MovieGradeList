//
//  ImageCacheService.swift
//  MovieGradeList
//
//  Created by 이동건 on 26/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class ImageCacheService {
    static let `default` = ImageCacheService()
    private var imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func save(key: String, value: UIImage) {
        guard imageCache.object(forKey: key as NSString) == nil else { return }
        imageCache.setObject(value, forKey: key as NSString)
    }
    
    func image(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
