//
//  PostListViewControllerTests.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import XCTest
@testable import tozemoga

final class PostListViewControllerTests: XCTestCase {
    var viewController: PostListViewController!
    var tableView: UITableView!
    var loadingIndicator: LoadingIndicatorView!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "PostListViewController") as? PostListViewController
        tableView = UITableView()
        viewController.tableView = tableView
        loadingIndicator = LoadingIndicatorView(style: .large)
        viewController.loadingIndicator = loadingIndicator
        viewController.viewDidLoad()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        tableView = nil
        loadingIndicator = nil
        viewController = nil
    }
    
    func testSetupTableView() {
        XCTAssertEqual(tableView.dataSource as? PostListViewController, viewController)
        XCTAssertEqual(tableView.delegate as? PostListViewController, viewController)
    }
    
    func testSetupLoadingIndicator() {
        XCTAssertEqual(loadingIndicator.style, .large)
        XCTAssertTrue(loadingIndicator.hidesWhenStopped)
    }
}
