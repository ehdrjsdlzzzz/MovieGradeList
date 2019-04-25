//
//  MovieCell.swift
//  MovieGradeList
//
//  Created by 이동건 on 24/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starRatingView: StarRatingView!
    
    private var movie: Movie.List?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        starRatingView.dataSource = self
    }
    
    func configure(_ movie: Movie.List?) {
        self.movie = movie
        titleLabel.text = movie?.title
        descriptionLabel.text = movie?.description
        starRatingView.layoutIfNeeded()
    }
}

extension MovieCell: StarRatingViewDataSource {
    func ratings() -> Double? {
        return movie?.rating
    }
}
