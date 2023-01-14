//
//  PostListViewModel.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-11.
//

import Foundation

class PostsViewModel {
    private var apiController: ApiControllerProtocol
    var posts: [Post] = []
    var selectedPost: Post?
    var favorites: [Post] {
        return posts.filter { $0.isFavorite }
    }
    var unfavorites: [Post] {
        return posts.filter { !$0.isFavorite }
    }
    var onDataChanged: (() -> Void)?
    
    init(apiController: ApiControllerProtocol = ApiController()) {
        self.apiController = apiController
    }
    
    func numberOfPosts() -> Int {
        return posts.count
    }
    
    //To get single post
    func post(at index:Int) -> Post? {
        guard index < posts.count else { return nil }
        return index < favorites.count ? favorites[index] : unfavorites[index - favorites.count]
    }
    
    //To change favorite state of post
    func toggleFavorite(post: Post?) {
        guard let index = posts.firstIndex(where: { $0.id == post?.id }) else { return }
        posts[index].isFavorite = !posts[index].isFavorite
        onDataChanged?()
    }
    //To load posts from JSONPlaceholder API
    func loadPosts() {
        apiController.load(endpoint: .posts) { [weak self] (result: Result<[Post], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                self.posts = posts
                self.onDataChanged?()
            case .failure(let error):
                // handle the error
                print("Error: \(error.localizedDescription)")
                break
            }
        }
    }
    
    //To delete single post
    func deletePost(post: Post) {
        let index = posts.firstIndex { $0.id == post.id }
        if let index = index {
            posts.remove(at: index)
            self.onDataChanged?()
        }
    }
    
    //To delete single post
    func deleteUnfavoritePosts() {
        posts = favorites
        self.onDataChanged?()
    }
}
