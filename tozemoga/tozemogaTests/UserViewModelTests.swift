//
//  UserViewModelTests.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import XCTest
@testable import tozemoga

final class UserViewModelTests: XCTestCase {
    
    var mockApiController: MockApiController!
    var viewModel: UserViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockApiController = MockApiController()
        viewModel = UserViewModel(userId: 1, apiController: mockApiController)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockApiController = nil
        viewModel = nil
    }
    
    func test_loadUserInfo_success() {
        // Given
        let expectedUser = User(id: 1, name: "John Doe", username: "johndoe", email: "johndoe@example.com", address: nil, phone: "555-555-5555", website: "www.johndoe.com", company: nil)
        mockApiController.user = expectedUser
        var error: Error?
        
        // When
        viewModel.loadUserInfo { error = $0 }
        
        // Then
        XCTAssertNil(error)
        XCTAssertEqual(viewModel.userInfo().name, expectedUser.name)
    }
    
    func test_loadUserInfo_failure() {
        // Given
        let expectedError = NSError(domain: "test", code: 0, userInfo: nil)
        mockApiController.error = expectedError
        var error: Error?
        
        // When
        viewModel.loadUserInfo { error = $0 }
        
        // Then
        XCTAssertEqual(error as NSError?, expectedError)
    }
}
