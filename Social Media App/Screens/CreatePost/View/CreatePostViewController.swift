//
//  CreatePostViewController.swift
//  Social Media App
//
//  Created by hammad aghar on 14/05/2024.
//

import UIKit
import MBProgressHUD

protocol CreatePostViewControllerProtocol: NSObjectProtocol{
    func addPost(post: Post)
}

class CreatePostViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var postTextView: UITextView!
    
    //MARK: - Variables
    weak var delegate: CreatePostViewControllerProtocol?
    private var viewModel = PostViewModel()
    
    //MARK: - IBActions
    @IBAction func postBtnTapped(_ sender: Any) {
        if let user = appManager.getUser(), let text = postTextView.text, text != "" {
            var post = Post(postId: 67, title: titleLabel.text, body: text, likes: 0, isLiked: false, comments: 5, user: user)
            createPost(post: post)
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    func createPost(post: Post) {
        viewModel.createPost(post: post)
    }
}

extension CreatePostViewController {
    
    func configuration() {
        observeEvent()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                // Indicator show
                print("Product loading....")
                DispatchQueue.main.async {
                    MBProgressHUD.showAdded(to: self.view, animated: true)
                }
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
                }
            case .newPostAdded(let post):
                delegate?.addPost(post: post)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .error(let error):
                print(error ?? "")
            }
        }
    }
}
