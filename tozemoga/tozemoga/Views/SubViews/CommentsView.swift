//
//  CommentsView.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-12.
//

import UIKit

class CommentsView: UIView {
    
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var commentsTableViewHeight: NSLayoutConstraint!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func configureView(for comments:[Comment]) {
        commentsTableView.dataSource = self
        commentsTableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsTableViewCell")
        self.comments = comments
    }
    
    var comments: [Comment]? {
        didSet {
            self.commentsTableViewHeight.constant = CGFloat.greatestFiniteMagnitude
            self.commentsTableView.reloadData()
            self.commentsTableView.layoutIfNeeded()
            self.commentsTableViewHeight.constant = self.commentsTableView.contentSize.height
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
extension CommentsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell
        let comment = comments?[indexPath.row]
        cell.comment = comment
        return cell
    }
}
