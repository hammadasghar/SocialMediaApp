//
//  CommentTVC.swift
//  Social Media App
//
//  Created by hammad aghar on 13/05/2024.
//

import UIKit

class CommentTVC: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setContent(_ data: Any?) {
        guard let data = data as? Comment else { return }
        nameLabel.text = data.name
        commentLabel.text = data.body
    }
    
}
