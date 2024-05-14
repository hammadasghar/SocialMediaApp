//
//  Comment.swift
//  Social Media App
//
//  Created by hammad aghar on 13/05/2024.
//

import Foundation

struct Comment: Codable {
    let postID:Int?
    let name: String?
    let body: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case name
        case body
    }
}
