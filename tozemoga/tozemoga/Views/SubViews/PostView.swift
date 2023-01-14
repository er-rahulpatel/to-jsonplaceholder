//
//  PostView.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-12.
//

import UIKit

class PostView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var post: Post? {
        didSet {
            titleLabel.text = post?.title
            descriptionLabel.text = post?.body
        }
    }
}
