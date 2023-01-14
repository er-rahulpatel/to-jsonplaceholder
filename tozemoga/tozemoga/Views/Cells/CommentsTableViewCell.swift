//
//  CommentsTableViewCell.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-12.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var comment: Comment? {
        didSet {
            nameLabel.text = comment?.name
            commentLabel.text = comment?.body
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
    
}
