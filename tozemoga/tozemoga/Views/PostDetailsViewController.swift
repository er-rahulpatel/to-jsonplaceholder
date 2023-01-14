//
//  PostDetailsViewController.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-11.
//

import UIKit

class PostDetailsViewController: UIViewController {
    // MARK: - Variables
    let apiController = ApiController()
    var post: Post!
    var delegate: PostDetailsViewProtocol?
    var viewModel: PostDetailsViewModel!
    @IBOutlet weak var postView: PostView!
    @IBOutlet weak var userView: UserView!
    @IBOutlet weak var commentView: CommentsView!
    @IBOutlet weak var isFavoriteButton: UIButton!
    var loadingIndicator: LoadingIndicatorView!
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        bindViewModel()
        showPostView()
        showUserView()
        showCommentsView()
        updateFavoriteButtonState()
    }
    // MARK: - Private functions
    private func setupLoadingIndicator() {
        loadingIndicator = LoadingIndicatorView(style: .large)
        loadingIndicator.configure(for: self.view, apiController: apiController)
    }
    
    private func bindViewModel() {
        viewModel = PostDetailsViewModel(post: post, apiController: apiController)
    }
    
    private func showPostView() {
        postView.post = viewModel.post
    }
    
    private func showUserView() {
        viewModel.fetchUser { [weak self] error in
            if let error = error {
                // handle the error
                print("Error: \(error.localizedDescription)")
            }
            guard let self = self else { return }
            self.userView.user = self.viewModel.userInfo()
        }
    }
    
    private func showCommentsView(){
        viewModel.fetchComments { [weak self] error in
            if let error = error {
                // handle the error
                print("Error: \(error.localizedDescription)")
            }
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.commentView.configureView(for: self.viewModel.comments())
            }
        }
    }
    
    func updateFavoriteButtonState(){
        isFavoriteButton.setImage(viewModel.isPostFavorite() ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")  , for: .normal)
    }
    
    // MARK: - IBActions
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
}
