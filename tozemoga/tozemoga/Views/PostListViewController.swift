//
//  PostListViewController.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-11.
//

import UIKit

class PostListViewController: UIViewController {
    var viewModel : PostsViewModel!
    let apiController = ApiController()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noPostLabel: UILabel!
    var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        setupLoadingIndicator()
        viewModel.loadPosts()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
    }
    private func loadingObserver() -> (Bool) -> Void {
        return { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                DispatchQueue.main.async {
                    self.loadingIndicator.startAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(loadingIndicator)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.center = view.center
        apiController.isLoadingObserver = loadingObserver()
    }
    private func bindViewModel() {
        viewModel = PostsViewModel(apiController: apiController)
        viewModel.onDataChanged = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = (self.viewModel.numberOfPosts() == 0)
                self.noPostLabel.isHidden = !self.tableView.isHidden
            }
        }
    }
    @IBAction func deleteTapped(_ sender: Any) {
        if(viewModel.unfavorites.count > 0){
            let alert = UIAlertController(title: "Delete Posts", message: "Are you sure you want to delete unfavorite posts?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] action in
                self?.viewModel.deleteUnfavoritePosts()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
            self.present(alert, animated: true)
        }else {
            let alert = UIAlertController(title: nil, message: "No unfavorite posts found.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func resyncPostsTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Fetch Posts", message: "Are you sure you want to fetch and refresh all posts?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            self?.viewModel.loadPosts()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(alert, animated: true)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPostDetail",
           let postDetailViewController = segue.destination as? PostDetailsViewController {
            postDetailViewController.post = viewModel.selectedPost
            postDetailViewController.delegate = self
        }
    }
}

extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let post = viewModel.post(at: indexPath.row)
        cell.post = post
        cell.toggleFavorite = { [weak self]  in
            guard let self = self else { return }
            self.viewModel.toggleFavorite(post: post)
        }
        return cell
    }
}

extension PostListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedPost = viewModel.post(at: indexPath.row)
        performSegue(withIdentifier: "showPostDetail", sender: nil)
        tableView .deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let post = viewModel.post(at: indexPath.row) else { return nil }
        let favoriteAction = UIContextualAction(style: .normal, title: post.isFavorite ? "Unfavorite" :
                                                    "Favorite") { _, _, completion in
            self.viewModel.toggleFavorite(post: post)
            completion(true)
        }
        favoriteAction.backgroundColor = post.isFavorite ? .gray : .systemTeal
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            let alert = UIAlertController(title: "Delete Post", message: "Are you sure you want to delete this post?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
                self?.viewModel.deletePost(post: post)
                completion(true)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler:{_ in
                completion(true)
            }))
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [ deleteAction,favoriteAction])
    }
    
}

extension PostListViewController: PostDetailsViewProtocol {
    func toggleFavorite(post: Post?) {
        viewModel.toggleFavorite(post: post)
    }
    
    func deletePost(post: Post) {
        viewModel.deletePost(post: post)
    }
}
