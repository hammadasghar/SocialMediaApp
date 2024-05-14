//
//  UIImage+Extension.swift
//  Social Media App
//
//  Created by Syed Hammad on 12/05/2024.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func setImage(with urlString: String) {
        self.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "img_place_holder"))
    }
}
