//
//  StarRatingView.swift
//  MovieGradeList
//
//  Created by 이동건 on 24/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

protocol StarRatingViewDataSource: class {
    func ratings() -> Double?
}

protocol StarRatingViewDelegate: class {
    func starRatingView(_ starRatingView: StarRatingView, ratingDidChanged: Double)
}

class StarRatingView: UIView {
    weak var delegate: StarRatingViewDelegate?
    weak var dataSource: StarRatingViewDataSource?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imagesStackView: UIStackView!
    
    private var rating: Double = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseInit()
    }
    
    func enableTapGesture() {
        addTapGesture()
    }
    
    func enablePanGesture() {
        addPanGesture()
    }
    
    private func baseInit() {
        Bundle.main.loadNibNamed("StarRatingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        fillStarsWithDataSource()
    }
    
    private func fillStarsWithDataSource() {
        self.rating = dataSource?.ratings() ?? 0
        fillStars(with: rating)
    }
    
    private func fillStars(with rating: Double?) {
        guard let rating = rating else { return }
        let starImages = StarService().makeStars(with: rating)
        let starImageViews = imagesStackView.subviews.compactMap { $0 as? UIImageView }
        for (image, imageView) in zip(starImages, starImageViews) {
            imageView.image = image
        }
    }
}

extension StarRatingView {
    private func addTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapRating)))
    }
    
    private func addPanGesture() {
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanRating)))
    }
    
    @objc func handleTapRating(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        calculateRating(from: location)
        delegate?.starRatingView(self, ratingDidChanged: rating)
    }
    
    @objc func handlePanRating(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let location = gesture.location(in: self)
            calculateRating(from: location)
        case .ended:
            delegate?.starRatingView(self, ratingDidChanged: rating)
        default:
            return
        }
    }
    
    private func calculateRating(from location: CGPoint) {
        let offset = location.x
        if let rawRating = Double(String(format: "%.1f", (offset / self.frame.width) * 5)) {
            self.rating = truncateRating(rawRating)
            fillStars(with: rating)
        }
    }
    
    private func truncateRating(_ rating: Double) -> Double {
        if rating > 5.0 {
            return 5.0
        }
        
        if rating < 0 {
            return 0
        }
        
        return rating
    }
}
