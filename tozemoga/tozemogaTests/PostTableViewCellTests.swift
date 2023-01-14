//
//  PostTableViewCellTests.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import XCTest
@testable import tozemoga

final class PostTableViewCellTests: XCTestCase {
    
    var cell: PostTableViewCell!
    var post: Post!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: PostTableViewCell.self)
        let nib = UINib(nibName: "PostTableViewCell", bundle: bundle)
        cell = nib.instantiate(withOwner: nil, options: nil).first as? PostTableViewCell
        post = Post(id: 1, userId: 1, title: "Test Title 1", body: "Test Body 1", isFavorite: false)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cell = nil
        post = nil
    }
    
    func testCell_WhenSetPost_TitleLabelShouldBeEqualToPostTitle() {
        cell.post = post
        XCTAssertEqual(cell.titleLabel.text, post.title)
    }
    
    func testCell_WhenSetPostIsFavoriteTrue_IsFavoriteButtonShouldBeStarFill() {
        post.isFavorite = true
        cell.post = post
        XCTAssertEqual(cell.isFavoriteButton.image(for: .normal), UIImage(systemName: "star.fill"))
    }
    
    func testCell_WhenSetPostIsFavoriteFalse_IsFavoriteButtonShouldBeStar() {
        post.isFavorite = false
        cell.post = post
        XCTAssertEqual(cell.isFavoriteButton.image(for: .normal), UIImage(systemName: "star"))
    }
    
    func testCell_WhenIsFavoriteButtonTapped_ShouldCallToggleFavoriteClosure() {
        var isClosureCalled = false
        cell.toggleFavorite = {
            isClosureCalled = true
        }
        cell.isFavoriteButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(isClosureCalled)
    }
    
}
