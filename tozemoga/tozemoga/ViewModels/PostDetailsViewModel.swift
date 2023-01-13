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
    
    func fetchUser(completion: @escaping () -> Void) {
        userViewModel.loadUserInfo { result in
            completion()
        }
    }
    
    func fetchComments(completion: @escaping () -> Void) {
        commentViewModel.loadComments(for: post) { result in
            completion()
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

