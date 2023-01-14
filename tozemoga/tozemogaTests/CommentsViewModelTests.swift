//
//  CommentsViewModelTests.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import XCTest
@testable import tozemoga

final class CommentsViewModelTests: XCTestCase {
    
    var mockApiController: MockApiController!
    var viewModel: CommentsViewModel!
    var post: Post!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockApiController = MockApiController()
        viewModel = CommentsViewModel(apiController: mockApiController)
        post = Post(id: 1, userId: 1, title: "Test Title", body: "Test Body", isFavorite: false)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockApiController = nil
        post = nil
        viewModel = nil
    }
    
    func test_loadComments_success() {
        // Given
        let expectedComment = Comment(id: 1, postId: 1, name: "name", email: "email", body: "body")
        mockApiController.comments = [expectedComment]
        var error: Error?
        
        // When
        viewModel.loadComments(for: post, completion: { error = $0 })
        
        // Then
        XCTAssertNil(error)
        XCTAssertEqual(viewModel.comments[0].name , expectedComment.name)
    }
    
    func test_loadComments_failure() {
        // Given
        let expectedError = NSError(domain: "test", code: 0, userInfo: nil)
        mockApiController.error = expectedError
        var error: Error?
        
        // When
        viewModel.loadComments(for: post, completion: { error = $0 })
        
        // Then
        XCTAssertEqual(error as NSError?, expectedError)
    }
    
}
