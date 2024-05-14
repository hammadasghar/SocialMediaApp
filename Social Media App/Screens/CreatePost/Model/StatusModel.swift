//
//  StatusModel.swift
//  Social Media App
//
//  Created by hammad aghar on 14/05/2024.
//

import Foundation

struct StatusModel: Codable {
    let status: Bool?
    let message: String?

    private enum CodingKeys: String, CodingKey {
        case status
        case message
    }
}
