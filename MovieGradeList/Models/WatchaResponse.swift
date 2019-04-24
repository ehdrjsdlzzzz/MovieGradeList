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
    var code: String
    var title: String
    var year: Int
    var poster: String
    var stillcut: String
    var nation: String
    var genre: String
}
