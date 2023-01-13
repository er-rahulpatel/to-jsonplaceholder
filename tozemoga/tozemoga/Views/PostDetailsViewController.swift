//
//  PostDetailsViewController.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-11.
//

import UIKit

class PostDetailsViewController: UIViewController {
    let apiController = ApiController()
    var post: Post!
    var delegate: PostDetailsViewProtocol?
    var viewModel: PostDetailsViewModel!
    @IBOutlet weak var postView: PostView!
    @IBOutlet weak var userView: UserView!
    @IBOutlet weak var commentView: CommentsView!
    @IBOutlet weak var isFavoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        showPostView()
        showUserView()
        showCommentsView()
        updateFavoriteButtonState()
    }
    
    private func bindViewModel() {
        viewModel = PostDetailsViewModel(post: post, apiController: apiController)
    }
    
    private func showPostView() {
        postView.post = viewModel.post
    }
    
    private func showUserView() {
        viewModel.fetchUser { [weak self] in
            guard let self = self else { return }
            self.userView.user = self.viewModel.userInfo()
        }
    }
    
    private func showCommentsView(){
        viewModel.fetchComments { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.commentView.configureView(for: self.viewModel.comments())
            }
        }
    }
    
    private func updateFavoriteButtonState(){
        isFavoriteButton.setImage(viewModel.isPostFavorite() ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")  , for: .normal)
    }
    
    
    @IBAction func deletePostTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Post", message: "Are you sure you want to delete this post?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] action in
            guard let self = self else {return}
            guard let delegate = self.delegate else {return}
            delegate.deletePost(post: self.viewModel.post)
            self.navigationController?.popViewController(animated: true)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(alert, animated: true)
        
    }
    
    @IBAction func favoriteTapped(_ sender: Any) {
        viewModel.toggleFavorite()
        updateFavoriteButtonState()
        guard let delegate = delegate else {return}
        delegate.toggleFavorite(post: viewModel.post)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
