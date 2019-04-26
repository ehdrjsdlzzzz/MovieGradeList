//
//  MainViewPresenter.swift
//  MovieGradeList
//
//  Created by 이동건 on 26/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import Foundation

protocol MainViewType: class {
    func reloadMovieCollectionView()
    func showError(_ error: Error)
}

class MainViewPresenter {
    private var movies: [Movie] = []
    private var parser: ParseSerive
    
    weak var vc: MainViewType?
    
    var moviesCount: Int {
        return movies.count
    }
    
    init(parser: ParseSerive) {
        self.parser = parser
    }
    
    func attatchView(_ vc: MainViewType) {
        self.vc = vc
    }
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    func upgrade(rating: Double, at index: Int) {
        movies[index].updateRating(rating)
        vc?.reloadMovieCollectionView()
    }
    
    func fetchMovies() {
        do {
            movies = try parser.parse(.file("contents.json")).data
            vc?.reloadMovieCollectionView()
        }catch let error as Parser.ParseError {
            vc?.showError(error)
        }catch {
            vc?.showError(error)
        }
    }
}
