//
//  EndPoint.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-13.
//

import Foundation

enum Endpoint {
   case posts
   case post(id: Int)
   case user(userId: Int)
   case comments(postId: Int)
}

extension Endpoint {
   var path: String {
       switch self {
       case .posts: return "/posts"
       case .post(let id): return "/posts/\(id)"
       case .user(let userId): return "/users/\(userId)"
       case .comments(let postId): return "/comments?postId=\(postId)"
       }
   }
}
