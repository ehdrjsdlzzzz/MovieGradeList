//
//  WatchaResponse.swift
//  MovieGradeList
//
//  Created by 이동건 on 24/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import Foundation

struct WatchaResponse: Decodable {
    var data: [Movie]
}

struct Movie: Decodable {
    private var code: String
    private var title: String
    private var year: Int
    private var poster: String
    private var stillcut: String
    private var nation: String
    private var genre: String
    
    var listModel: List? {
        let description = "\(year) • \(nation)"
        return List(title: title, posterURL: URL(string: poster), description: description)
    }
}

extension Movie {
    struct List {
        var title: String
        var posterURL: URL?
        var description: String
    }
}
