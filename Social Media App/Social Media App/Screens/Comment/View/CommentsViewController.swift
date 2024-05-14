//
//  CommentsViewController.swift
//  Social Media App
//
//  Created by hammad aghar on 13/05/2024.
//

import UIKit
import MBProgressHUD

class CommentsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    
    // MARK: - Variables
    var postId: Int?
    private var viewModel = CommentViewModel()
    
    // MARK: - IBActions
    @IBAction func saveCommentTapped(_ sender: Any) {
        if let user = appManager.getUser(), let name = user.name, commentTextView.text != "" {
            let comment = Comment(postID: self.postId, name: name, body: commentTextView.text)
            postComment(comment: comment)
            commentTextView.text = ""
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

}


extension CommentsViewController {
    
    func configuration() {
        commentsTableView.register(UINib(nibName: "CommentTVC", bundle: nil), forCellReuseIdentifier: "CommentTVC")
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.backgroundColor = .lightGray
        commentsTableView.separatorStyle = .none
        commentsTableView.showsVerticalScrollIndicator = false
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        if let id = postId {
            DispatchQueue.main.async {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            }
            viewModel.fetchComments(postId: id)
        }
    }
    func postComment(comment: Comment) {
        if let id = postId {
            DispatchQueue.main.async {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            }
            viewModel.addComment(comment: comment)
        }
    }

    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {

            case .stopLoading:
                // Indicator hide
                print("Stop loading...")
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    self.commentsTableView.reloadData()
                }
            case .commentAdded(let comment):
                viewModel.comments.insert(comment, at: 0)
                DispatchQueue.main.async {
                    self.commentsTableView.reloadData()
                }
            case .error(let error):
                print(error ?? "")

            }
        }
    }
    
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTVC") as? CommentTVC else {
            return UITableViewCell()
        }
        cell.setContent(viewModel.comments[indexPath.row])
        return cell
    }
    
}

