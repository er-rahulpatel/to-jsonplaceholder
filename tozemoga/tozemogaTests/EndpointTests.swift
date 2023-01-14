//
//  EndpointTests.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import XCTest
@testable import tozemoga

final class EndpointTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPathForPosts() {
        let endpoint = Endpoint.posts
        XCTAssertEqual(endpoint.path, "/posts")
    }
    
    func testPathForPost() {
        let endpoint = Endpoint.post(id: 1)
        XCTAssertEqual(endpoint.path, "/posts/1")
    }
    
    func testPathForUser() {
        let endpoint = Endpoint.user(userId: 2)
        XCTAssertEqual(endpoint.path, "/users/2")
    }
    
    func testPathForComments() {
        let endpoint = Endpoint.comments(postId: 3)
        XCTAssertEqual(endpoint.path, "/comments?postId=3")
    }
    
}
