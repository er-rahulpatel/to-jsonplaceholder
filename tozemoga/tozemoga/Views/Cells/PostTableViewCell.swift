//
//  PostTableViewCell.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-11.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isFavoriteButton: UIButton!
    var toggleFavorite: (()->())?
    
    var post: Post? {
        didSet {
            titleLabel.text = post?.title
            isFavoriteButton.setImage(post!.isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")  , for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func favoriteTapped(_ sender: Any) {
        toggleFavorite?()
        
    }
}
