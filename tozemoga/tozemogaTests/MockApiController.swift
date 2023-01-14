//
//  MockApiController.swift
//  tozemogaTests
//
//  Created by Applanding Solutions on 2023-01-13.
//

import Foundation
@testable import tozemoga

class MockApiController: ApiControllerProtocol{
    var isCalled: Bool = false
    var isLoading: Bool = false
    var isLoadingObserver: ((Bool) -> Void)?
    var posts: [Post] = []
    var user: User?
    var comments: [Comment] = []
    var error: Error?
    
    func load<T>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Decodable {
        isCalled = true
        if error != nil {
            completion(.failure(error!))
            return
        }
        if T.self == [Post].self {
            completion(.success(posts as! T))
            return
        }
        if T.self == Post.self {
            let post = posts.first! as! T
            completion(.success(post))
            return
        }
        if T.self == User.self {
            completion(.success(user as! T))
            return
        }
        
        if T.self == [Comment].self {
            completion(.success(comments as! T))
            return
        }
    }
    
    func setLoadingObserver(observer: @escaping (Bool) -> Void) {
        isLoadingObserver = observer
    }
    
    func setLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
        isLoadingObserver?(isLoading)
    }
}
