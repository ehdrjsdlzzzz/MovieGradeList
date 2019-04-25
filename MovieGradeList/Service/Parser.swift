//
//  Parser.swift
//  MovieGradeList
//
//  Created by 이동건 on 24/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import Foundation

protocol ParseSerive {
    func parse(_ contentType: ContentRepositoryType) throws -> WatchaResponse
}

class Parser: ParseSerive {
    func parse(_ contentType: ContentRepositoryType) throws -> WatchaResponse {
        guard let url = contentType.path else { throw ParseError.invalidPath }
        let data = try readData(from: url)
        let response = try decode(data)
        return response
    }
    
    private func readData(from url: URL) throws -> Data {
        do {
            return try Data(contentsOf: url)
        }catch {
            throw ParseError.invalidPath
        }
    }
    
    private func decode(_ data: Data) throws -> WatchaResponse {
        do {
            return try JSONDecoder().decode(WatchaResponse.self, from: data)
        }catch {
            throw ParseError.decodeFailed
        }
    }
}

extension Parser {
    enum ParseError: Error, CustomStringConvertible {
        case invalidPath
        case decodeFailed
        
        var description: String {
            switch self {
            case .invalidPath:
                return "유효하지 않는 주소입니다"
            case .decodeFailed:
                return "디코딩에 실패하였습니다"
            }
        }
    }
}
