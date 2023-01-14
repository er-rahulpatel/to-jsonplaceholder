//
//  Post.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-11.
//

import Foundation

struct Post: Codable, Equatable {
    let id: Int
    let userId: Int
    let title: String?
    let body: String?
    var isFavorite: Bool = false
    
    init(id: Int, userId: Int, title: String?, body: String?, isFavorite: Bool) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
        self.isFavorite = isFavorite
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        userId = try container.decode(Int.self, forKey: .userId)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
        isFavorite = false
    }
}
