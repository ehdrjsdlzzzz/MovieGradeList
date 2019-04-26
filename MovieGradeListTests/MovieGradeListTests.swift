//
//  MovieGradeListTests.swift
//  MovieGradeListTests
//
//  Created by 이동건 on 24/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import XCTest
@testable import MovieGradeList

class MovieGradeListTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidLocalRepository() {
        XCTAssertNotNil(ContentRepositoryType.file("contents.json").path)
    }
    
    func testInvalidLocalRepository() {
        XCTAssertNotNil(ContentRepositoryType.file("contents.jon").path)
    }
    
    func testValidRemoteRepostiory() {
        XCTAssertNotNil(ContentRepositoryType.url("https://www.google.com").path)
    }
    
    func testInvalidRemoteRepostiory() {
        XCTAssertNotNil(ContentRepositoryType.url("https://wwww.google.coㅡ").path)
    }
    
    func testParserWithInvalidLocalRepository() {
        XCTAssertThrowsError(try Parser().parse(.file("contents.jon")))
    }
    
    func testParserWithInvalidRemoteRepository() {
        XCTAssertThrowsError(try Parser().parse(.file("https://wwww.google.coㅡ")))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
