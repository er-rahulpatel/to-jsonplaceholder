//
//  Comment.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-11.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let postId: Int
    let name: String?
    let email: String?
    let body: String?
}
