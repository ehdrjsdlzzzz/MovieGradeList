//
//  ContentType.swift
//  MovieGradeList
//
//  Created by 이동건 on 24/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import Foundation

enum ContentType {
    case file(_ name: String)
    case url(_ rawURL: String)
    
    var path: URL? {
        switch self {
        case .file(let name):
            return makeFilePath(from: name)
        case .url(let url):
            return URL(string: url)
        }
    }
    
    private func makeFilePath(from rawPath: String) -> URL? {
        let splited = rawPath.split(separator: ".").map { String($0) }
        return Bundle.main.url(forResource: splited[0], withExtension: splited[1])
    }
}
