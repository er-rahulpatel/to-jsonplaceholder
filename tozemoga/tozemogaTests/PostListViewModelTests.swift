//
//  PostListViewModelTests.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import XCTest
@testable import tozemoga

final class PostListViewModelTests: XCTestCase {
    
    var viewModel: PostsViewModel!
    var mockApiController: MockApiController!
    var posts: [Post]!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockApiController = MockApiController()
        viewModel = PostsViewModel(apiController: mockApiController)
        posts = [Post(id: 1, userId: 1, title: "Test Title 1", body: "Test Body 1", isFavorite: false),
                 Post(id: 2, userId: 1, title: "Test Title 2", body: "Test Body 2", isFavorite: true)]
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockApiController = nil
        posts = nil
        viewModel = nil
    }
    
    func testLoadPosts_whenSuccess_shouldCallApi() {
        let expectation = self.expectation(description: "fetchPosts")
        mockApiController.posts = posts
        viewModel.loadPosts()
        XCTAssertTrue(mockApiController.isCalled)
        XCTAssertEqual(posts, viewModel.posts)
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testToggleFavorite_shouldToggleIsFavorite() {
        viewModel.posts = posts
        viewModel.toggleFavorite(post: posts[0])
        XCTAssertTrue(viewModel.posts[0].isFavorite)
        viewModel.toggleFavorite(post: posts[0])
        XCTAssertFalse(viewModel.posts[0].isFavorite)
    }
    
    func testDeleteNonFavoritePosts_shouldDeleteNonFavoritePosts() {
        viewModel.posts = posts
        viewModel.deleteUnfavoritePosts()
        XCTAssertEqual(viewModel.posts, [posts[1]])
    }
}

