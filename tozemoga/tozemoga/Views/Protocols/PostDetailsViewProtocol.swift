//
//  PostDetailsViewProtocol.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-13.
//

import Foundation

protocol PostDetailsViewProtocol {
    func toggleFavorite(post: Post?)
    func deletePost(post: Post)
}
