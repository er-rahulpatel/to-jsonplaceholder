//
//  PostDetailsViewModelTests.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import XCTest
@testable import tozemoga

final class PostDetailsViewModelTests: XCTestCase {
    
    var viewModel: PostDetailsViewModel!
    var mockApiController: MockApiController!
    var post: Post!
    var comments: [Comment]!
    var user: User!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockApiController = MockApiController()
        post = Post(id: 1, userId: 1, title: "Test Title", body: "Test Body", isFavorite: false)
        comments = [Comment(id: 1, postId: 1, name: "Test Comment", email: "test@example.com", body: "Test Body")]
        user = User(id: 1, name: "Test Author", username: "Test Author", email: "test@example.com", address: nil, phone: "672-XXX-XXXX", website: "test.com", company: nil)
        viewModel = PostDetailsViewModel(post: post, apiController: mockApiController)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockApiController = nil
        post = nil
        comments = nil
        user = nil
        viewModel = nil
    }
    
    func testFetchUser() {
        let expectation = self.expectation(description: "fetchUser")
        mockApiController.user = user
        viewModel.fetchUser { [weak self] error in
            guard let self = self else {return}
            XCTAssertTrue(self.mockApiController.isCalled)
            XCTAssertEqual(self.viewModel.userInfo().id, self.user.id)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchComments() {
        let expectation = self.expectation(description: "fetchComments")
        mockApiController.comments = comments
        viewModel.fetchComments { [weak self] error in
            guard let self = self else {return}
            XCTAssertEqual(self.viewModel.comments().count, self.comments.count)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testToggleFavorite_shouldToggleIsFavorite() {
        viewModel.toggleFavorite()
        XCTAssertTrue(viewModel.isPostFavorite())
        viewModel.toggleFavorite()
        XCTAssertFalse(viewModel.isPostFavorite())
    }
    
    func testIsPostFavorite(){
        XCTAssertFalse(viewModel.isPostFavorite())
    }
}
