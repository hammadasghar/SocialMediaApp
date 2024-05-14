//
//  SocialPostsTVC.swift
//  Social Media App
//
//  Created by hammad aghar on 13/05/2024.
//

import UIKit

protocol SocialPostsTVCProtocol: NSObjectProtocol {
    func getComments(postId: Int)
    func likePost(cell: UITableViewCell)
}
class SocialPostsTVC: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    //MARK: - Variables
    var postData: Post?
    weak var delegate: SocialPostsTVCProtocol?

    // MARK: - IBActions
    @IBAction func commentBtnTapped(_ sender: Any) {
        if let post = postData, let id = post.postId {
            delegate?.getComments(postId: id)
        }
    }
    
    @IBAction func likeBtnTapped(_ sender: Any) {
        delegate?.likePost(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(_ data: Any?) {
        guard let data = data as? Post else { return }
        self.postData = data
        if let user = data.user, let name = user.name, let address = user.address {
            profileImageView.setImage(with: user.profileImg ?? "")
            nameLabel.text = name
            locationLabel.text = "\(address.city ?? ""), \(address.country ?? "")"
            postLabel.text = data.body
            likesLabel.text = "\(data.likes ?? 0) Likes"
            commentsLabel.text = "\(data.comments ?? 0) Comments"
            DispatchQueue.main.async { [self] in
                likeButton.imageView?.tintColor = data.isLiked ?? false ? .blue: .lightGray
            }
        }
        
        if let title = data.title, title != "" {
            titleLabel.text = title
        } else {
            titleLabel.isHidden = true
        }
        
    }
}
