//
//  StarMaker.swift
//  MovieGradeList
//
//  Created by 이동건 on 24/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

struct StarService {
    func makeStars(with rate: Double) -> [UIImage] {
        let digit = Int(rate)
        let decimalPoint = rate - Double(digit)
        return calculateStars(digit, decimalPoint)
    }
    
    private func calculateStars(_ digit: Int, _ decimalPoint: Double) -> [UIImage] {
        var stars = makeFullStars(digit)
        stars.append(makeStar(decimalPoint))
        let emptyStarsCount = 5 - stars.count
        stars += makeEmptyStar(emptyStarsCount)
        return stars
    }
    
    private func makeFullStars(_ count: Int) -> [UIImage] {
        return Array(repeating: StarType.full.image, count: count).compactMap { $0 }
    }
    
    private func makeStar(_ decimalPoint: Double) -> UIImage {
        guard decimalPoint != 0 else { return StarType.empty.image }
        
        if decimalPoint > 0.2 && decimalPoint <= 0.5 {
            return StarType.half.image
        }
        
        if decimalPoint > 0.5 {
            return StarType.full.image
        }
        
        return StarType.empty.image
    }
    
    private func makeEmptyStar(_ count: Int) -> [UIImage] {
        guard count >= 0 else { return [] }
        return Array(repeating: StarType.empty.image, count: count).compactMap { $0 }
    }
}

extension StarService {
    enum StarType: String {
        case empty
        case half
        case full
        
        var image: UIImage {
            return UIImage(named: "ic_star_large_\(self.rawValue)") ?? UIImage()
        }
    }
}
