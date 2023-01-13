//
//  MockApiController.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import Foundation
@testable import tozemoga

class MockApiController: ApiControllerProtocol{
    var isCalled = false
    func load<T>(endpoint: tozemoga.Endpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        isCalled = true
        completion(Result<T,Error>(catching: {
            throw NSError()
        }))
    }
}
