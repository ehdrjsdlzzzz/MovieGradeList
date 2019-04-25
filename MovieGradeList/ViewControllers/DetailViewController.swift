//
//  DetailViewController.swift
//  MovieGradeList
//
//  Created by 이동건 on 24/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

protocol MovieDetailViewDataSource: class {
    func movieDetail() -> Movie.Detail?
}

protocol MovieDetailViewDelegate: class {
    func movieDetailView(_ movieDetailView: DetailViewController, ratingDidChanged: Double)
}

class DetailViewController: UIViewController {
    weak var dataSource: MovieDetailViewDataSource?
    weak var delegate: MovieDetailViewDelegate?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var stillcutImageView: UIImageView!
    @IBOutlet weak var ratingInfoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starRatingView: StarRatingView!
    
    private var movie: Movie.Detail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starRatingView.dataSource = self
        starRatingView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    private func configure() {
        movie = dataSource?.movieDetail()
        titleLabel.text = movie?.title
        descriptionLabel.text = movie?.description
        starRatingView.enableTapGesture()
        starRatingView.enablePanGesture()
        starRatingView.layoutIfNeeded()
    }
}

extension DetailViewController: StarRatingViewDelegate {
    func starRatingView(_ starRatingView: StarRatingView, ratingDidChanged: Double) {
        delegate?.movieDetailView(self, ratingDidChanged: ratingDidChanged)
    }
}

extension DetailViewController: StarRatingViewDataSource {
    func ratings() -> Double? {
        return movie?.rating
    }
}
