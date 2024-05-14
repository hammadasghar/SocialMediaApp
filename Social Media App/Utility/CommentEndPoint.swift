//
//  CommentEndPoint.swift
//  Social Media App
//
//  Created by hammad aghar on 13/05/2024.
//

import Foundation

//
//  DashboardEndPoint.swift
//  Social Media App
//
//  Created by Syed Hammad on 12/05/2024.
//

enum CommentEndPoint {
    case comments(postId: Int)
    case addComment(comment: Comment)
}

extension CommentEndPoint: EndPointType {
    
    var path: String {
        switch self {
        case .comments:
            return "/comments"
        case .addComment:
            return "/posts"
        }
    }
    
    var baseURL: String {
        switch self {
        case .comments, .addComment:
            return "https://jsonplaceholder.typicode.com"
        }
    }
    
    var urlComponent: URLComponents? {
        var urlComponents = URLComponents(string: "\(baseURL)\(path)")
        var queryItems = [URLQueryItem]()
        for queryItem in parameters {
            queryItems.append(URLQueryItem(name: queryItem.key, value: queryItem.value))
        }
        urlComponents?.queryItems = queryItems
        return urlComponents
    }
    
    var url: URL? {
        return urlComponent?.url
    }
    
    var method: HTTPMethods {
        switch self {
        case .comments:
            return .get
        case .addComment:
            return .post
        }
    }
    
    var body: Encodable? {
        switch self {
        case .comments:
            return nil
        case .addComment(let comment):
            return comment
        }
    }
    
    var parameters: [String : String] {
        switch self {
        case .comments(let productId):
            return ["postId": "\(productId)"]
        case .addComment(comment: let comment):
            return [:]
        }
    }
    
    var headers: [String : String]? {
        APIManager.commonHeaders
    }
}
