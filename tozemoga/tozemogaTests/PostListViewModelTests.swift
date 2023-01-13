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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockApiController = MockApiController()
        viewModel = PostsViewModel(apiController: mockApiController)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadPosts_whenSuccess_shouldCallApi() {
        viewModel.loadPosts()
        XCTAssertTrue(mockApiController.isCalled)
    }
    
    func testToggleFavorite_shouldToggleIsFavorite() {
        let post = Post(id: 1, userId: 1, title: "Test Title", body: "Test Body", isFavorite: false)
        viewModel.posts = [post]
        
        viewModel.toggleFavorite(post: post)
        XCTAssertTrue(viewModel.posts[0].isFavorite)
        
        viewModel.toggleFavorite(post: post)
        XCTAssertFalse(viewModel.posts[0].isFavorite)
    }
    
    func testDeleteNonFavoritePosts_shouldDeleteNonFavoritePosts() {
        let post1 = Post(id: 1, userId: 1, title: "Test Title 1", body: "Test Body", isFavorite: false)
        let post2 = Post(id: 2, userId: 1, title: "Test Title 2", body: "Test Body", isFavorite: true)
        viewModel.posts = [post1, post2]
        
        viewModel.deleteUnfavoritePosts()
        XCTAssertEqual(viewModel.posts, [post2])
    }
    
}

