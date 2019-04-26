//
//  ViewController.swift
//  MovieGradeList
//
//  Created by 이동건 on 24/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- Properties
    private var presenter = MainViewPresenter(parser: Parser())
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPresenter()
    }
    
    // MARK:- Setup
    private func setupPresenter() {
        presenter.attatchView(self)
        presenter.fetchMovies()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: MovieCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
    }
    
    private func registerDefaultCell() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseIdentifier)
    }
}

extension ViewController: MainViewType {
    func reloadMovieCollectionView() {
        collectionView.reloadData()
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "ERROR", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
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

// MARK:- UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.moviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else {
            registerDefaultCell()
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier, for: indexPath)
            return cell
        }
        
        let listModel = presenter.movie(at: indexPath.item).listType
        cell.configure(listModel)
        return cell
    }
}

// MARK:- MovieDetailViewDataSource
extension ViewController: MovieDetailViewDataSource {
    func movieDetail() -> Movie.Detail? {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else { return nil }
        return presenter.movie(at: selectedIndexPath.item).detailType
    }
}

// MARK:- MovieDetailViewDelegate
extension ViewController: MovieDetailViewDelegate {
    func movieDetailView(_ movieDetailView: DetailViewController, ratingDidChanged: Double) {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        presenter.upgrade(rating: ratingDidChanged, at: selectedIndexPath.item)
    }
}

