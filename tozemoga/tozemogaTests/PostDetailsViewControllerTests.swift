//
//  PostDetailsViewControllerTests.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import XCTest
@testable import tozemoga

final class PostDetailsViewControllerTests: XCTestCase {
    
    var postDetailsViewController: PostDetailsViewController!
    var post: Post!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        postDetailsViewController = storyboard.instantiateViewController(withIdentifier: "PostDetailsViewController") as? PostDetailsViewController
        post = Post(id: 1, userId: 1, title: "Test post", body: "Test post body", isFavorite: false)
        postDetailsViewController.post = post
        _ = postDetailsViewController.view // force view to load
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        post = nil
        postDetailsViewController = nil
    }
    
    
    func testShowPostView() {
        XCTAssertEqual(postDetailsViewController.postView.post, post)
    }
    
    func testUpdateFavoriteButtonState() {
        post.isFavorite = false
        postDetailsViewController.updateFavoriteButtonState()
        XCTAssertEqual(postDetailsViewController.isFavoriteButton.image(for: .normal), UIImage(systemName: "star"))
    }
}


