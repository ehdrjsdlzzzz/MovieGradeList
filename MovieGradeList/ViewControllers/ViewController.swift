//
//  ViewController.swift
//  MovieGradeList
//
//  Created by 이동건 on 24/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var movies: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchMovies()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
    }
    
    private func fetchMovies() {
        do {
            movies = try Parser().parse(.file("contents.json")).data
        }catch let error as Parser.ParseError {
            print(error)
        }catch {
            print("unexpected Error")
        }
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: MovieCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
    }
    
    private func registerDefaultCell() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseIdentifier)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: DetailViewController.reuseIdentifier, bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as? DetailViewController else { return }
        detailViewController.dataSource = self
        detailViewController.delegate = self
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else {
            registerDefaultCell()
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier, for: indexPath)
            return cell
        }
        
        let listModel = movies[indexPath.item].listType
        cell.configure(listModel)
        return cell
    }
}

extension ViewController: MovieDetailViewDataSource {
    func movieDetail() -> Movie.Detail? {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else { return nil }
        return movies[selectedIndexPath.item].detailType
    }
}

extension ViewController: MovieDetailViewDelegate {
    func movieDetailView(_ movieDetailView: DetailViewController, ratingDidChanged: Double) {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        movies[selectedIndexPath.item].updateRating(ratingDidChanged)
        collectionView.reloadItems(at: [selectedIndexPath])
    }
}

