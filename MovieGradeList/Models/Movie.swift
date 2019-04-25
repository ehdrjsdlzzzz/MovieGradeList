//
//  Movie.swift
//  MovieGradeList
//
//  Created by 이동건 on 26/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    private var code: String
    private var title: String
    private var year: Int
    private var poster: String
    private var stillcut: String
    private var nation: String
    private var genre: String
    private var rating: Double? = 0
    
    var listType: List? {
        let description = "\(year) • \(nation)"
        return List(title: title, posterURL: URL(string: poster), description: description, rating: rating ?? 0)
    }
    
    var detailType: Detail? {
        let description = "\(year) • \(nation) • \(genre)"
        return Detail(title: title, posterURL: URL(string: poster), stillcutURL: URL(string: stillcut), description: description, rating: rating)
    }
    
    mutating func updateRating(_ rating: Double) {
        self.rating = rating
    }
}

extension Movie {
    struct List {
        var title: String
        var posterURL: URL?
        var description: String
        var rating: Double
    }
    
    struct Detail {
        var title: String
        var posterURL: URL?
        var stillcutURL: URL?
        var description: String
        var rating: Double?
    }
}
