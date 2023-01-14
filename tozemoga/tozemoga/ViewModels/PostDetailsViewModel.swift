//
//  PostDetailsViewModel.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-11.
//

import Foundation

class PostDetailsViewModel {
    private var apiController: ApiControllerProtocol
    var post: Post
    
    private var commentViewModel: CommentsViewModel
    private var userViewModel: UserViewModel
    
    init(post: Post, apiController: ApiControllerProtocol) {
        self.post = post
        self.apiController = apiController
        self.commentViewModel = CommentsViewModel(apiController: self.apiController)
        self.userViewModel = UserViewModel(userId: post.userId, apiController: self.apiController)
    }
    
    //To fetch user information
    func fetchUser(completion: @escaping (Error?) -> Void) {
        userViewModel.loadUserInfo { error in
            completion(error)
        }
    }
    
    //To fetch all comments for the post
    func fetchComments(completion: @escaping (Error?) -> Void) {
        commentViewModel.loadComments(for: post) { error in
            completion(error)
        }
    }
    
    func userInfo() -> User {
        return userViewModel.userInfo()
    }
    
    func comments() -> [Comment] {
        return commentViewModel.comments
    }
    
    func isPostFavorite() -> Bool {
        return post.isFavorite
    }
    
    func toggleFavorite() {
        post.isFavorite = !post.isFavorite
    }
}

