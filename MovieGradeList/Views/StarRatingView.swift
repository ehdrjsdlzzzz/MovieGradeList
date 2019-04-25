//
//  StarRatingView.swift
//  MovieGradeList
//
//  Created by 이동건 on 24/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

protocol StarRatingViewDataSource: class {
    func starImages() -> [UIImage]
}

protocol StarRatingViewDelegate: class {
    func starRatingView(_ starRatingView: StarRatingView, ratingDidChanged: Double)
}

class StarRatingView: UIView {
    weak var delegate: StarRatingViewDelegate?
    weak var dataSource: StarRatingViewDataSource?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imagesStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseInit()
    }
    
    private func baseInit() {
        Bundle.main.loadNibNamed("StarRatingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        fillStars()
    }
    
    private func fillStars() {
        guard let starImages = dataSource?.starImages() else { return }
        let starImageViews = imagesStackView.subviews.compactMap { $0 as? UIImageView }
        for (image, imageView) in zip(starImages, starImageViews) {
            imageView.image = image
        }
    }
}
