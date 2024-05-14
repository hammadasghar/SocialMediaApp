//
//  DashboardViewController.swift
//  Social Media App
//
//  Created by hammad aghar on 13/05/2024.
//

import UIKit
import MBProgressHUD

class DashboardViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Variables
    private var viewModel = DashboardViewModel()
    
    //MARk IB Actions
    @IBAction func postTapped(_ sender: Any) {
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
        destVC.delegate = self
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDummyUser()
        configuration()
    }
    
    func setDummyUser() {
        let user: User = User(id: 1, name: "Syed Hammad Asghar", profileImg: "https://mdbcdn.b-cdn.net/img/new/avatars/2.webp", address: Address(city: "Lahore", country: "Pakistan"))
        appManager.setUser(user: user)
    }
    
}

extension DashboardViewController {
    
    func configuration() {
        postsTableView.register(UINib(nibName: "SocialPostsTVC", bundle: nil), forCellReuseIdentifier: "SocialPostsTVC")
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        if let user = appManager.getUser(), let name = user.name {
            profileImageView.setImage(with: user.profileImg ?? "") // empty url will be handled and replaced by a placeholder image in setImage function
            nameLabel.text = "Hi, " + name
        }
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        viewModel.fetchPosts()
    }
    
    
    // Data binding event  - communication
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
                    self.postsTableView.reloadData()
                }
            case .postLiked:
                DispatchQueue.main.async {
                    self.postsTableView.reloadData()
                }
            case .error(let error):
                print(error ?? "")
            }
        }
    }
    
}
// MARK: - Table View Delegates
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SocialPostsTVC") as? SocialPostsTVC else {
            return UITableViewCell()
        }
        cell.setContent(viewModel.posts[indexPath.row])
        cell.delegate = self
        return cell
    }
    
}

extension DashboardViewController: SocialPostsTVCProtocol {
    
    func likePost(cell: UITableViewCell) {
        if let indexPath = postsTableView.indexPath(for: cell) {
            DispatchQueue.main.async {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            }
            viewModel.likePost(postId: indexPath.row)
        }
    }
    
    func getComments(postId: Int) {
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        destVC.postId = postId
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}

extension DashboardViewController: CreatePostViewControllerProtocol {
    func addPost(post: Post) {
        viewModel.posts.insert(post, at: 0)
        DispatchQueue.main.async {
            self.postsTableView.reloadData()
        }
    }
}
