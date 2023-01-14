//
//  PostTests.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import XCTest
@testable import tozemoga

final class PostTests: XCTestCase {
    
    var post: Post!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        post = Post(id: 1, userId: 1, title: "Test Title", body: "Test Body", isFavorite: false)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPostProperties() {
        XCTAssertEqual(post.id, 1)
        XCTAssertEqual(post.userId, 1)
        XCTAssertEqual(post.title, "Test Title")
        XCTAssertEqual(post.body, "Test Body")
        XCTAssertFalse(post.isFavorite)
    }
    
}
