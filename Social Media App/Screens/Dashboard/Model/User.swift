//
//  User.swift
//  Social Media App
//
//  Created by Syed Hammad on 12/05/2024.
//

import Foundation

struct User: Codable {
    let id: Int?
    let name: String?
    let profileImg: String?
    let address: Address?
}
struct Address: Codable {
    let city: String?
    let country: String?
}
