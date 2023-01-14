//
//  CommentsTableViewCellTests.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import XCTest
@testable import tozemoga

final class CommentsTableViewCellTests: XCTestCase {
    var cell: CommentsTableViewCell!
    var comment: Comment!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: CommentsTableViewCell.self)
        let nib = UINib(nibName: "CommentsTableViewCell", bundle: bundle)
        cell = nib.instantiate(withOwner: nil, options: nil).first as? CommentsTableViewCell
        comment = Comment(id: 1, postId: 1, name: "name", email: "email", body: "body")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cell = nil
    }
    
    func test_awakeFromNib_configuresCell() {
        // Given
        cell.comment = comment
        // When
        cell.awakeFromNib()
        // Then
        XCTAssertEqual(cell.nameLabel.text, comment.name)
        XCTAssertEqual(cell.commentLabel.text, comment.body)
    }
    
}
