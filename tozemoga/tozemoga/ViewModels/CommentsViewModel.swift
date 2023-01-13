//
//  CommentsViewModel.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-12.
//

import Foundation

class CommentsViewModel {
    private var apiController: ApiControllerProtocol
    var comments: [Comment] = []
    init(apiController: ApiControllerProtocol) {
        self.apiController = apiController
    }
    
    //To load posts from JSONPlaceholder API
    func loadComments(for post:Post, completion: @escaping (Result<[Comment], Error>) -> Void) {
        apiController.load(endpoint: .comments(postId: post.id)) { [weak self] (result: Result<[Comment], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let comments):
                self.comments = comments
                completion(.success(comments))
            case .failure(let error):
                // handle the error
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                break
            }
        }
    }
}
