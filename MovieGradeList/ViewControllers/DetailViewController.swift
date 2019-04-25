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
    // MARK:- Outlets
    @IBOutlet weak var posterImageView: CachableImageView!
    @IBOutlet weak var stillcutImageView: CachableImageView!
    @IBOutlet weak var ratingInfoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starRatingView: StarRatingView!
    
    // MARK:- Propertes
    weak var dataSource: MovieDetailViewDataSource?
    weak var delegate: MovieDetailViewDelegate?
    private var movie: Movie.Detail?
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStarRatingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    // MARK:- Setup
    private func configure() {
        movie = dataSource?.movieDetail()
        titleLabel.text = movie?.title
        descriptionLabel.text = movie?.description
        fetchImages()
        starRatingView.layoutIfNeeded()
    }
    
    private func setupStarRatingView() {
        starRatingView.dataSource = self
        starRatingView.delegate = self
        starRatingView.enableTapGesture()
        starRatingView.enablePanGesture()
    }
    
    // MARK:- Fetch
    private func fetchImages() {
        if let stillcutURL = movie?.stillcutURL {
            stillcutImageView.loadImage(urlString: stillcutURL.absoluteString)
        }
        if let posterURL = movie?.posterURL {
            posterImageView.loadImage(urlString: posterURL.absoluteString)
        }
    }
}

// MARK:- StarRatingViewDelegate
extension DetailViewController: StarRatingViewDelegate {
    func starRatingView(_ starRatingView: StarRatingView, ratingDidChanged: Double) {
        delegate?.movieDetailView(self, ratingDidChanged: ratingDidChanged)
    }
}

// MARK:- StarRatingViewDataSource
extension DetailViewController: StarRatingViewDataSource {
    func ratings() -> Double? {
        return movie?.rating
    }
}
