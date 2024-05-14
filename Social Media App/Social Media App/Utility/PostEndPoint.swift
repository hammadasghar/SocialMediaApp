//
//  PostEndPoint.swift
//  Social Media App
//
//  Created by hammad aghar on 14/05/2024.
//

import Foundation

enum PostEndPoint {
    case createPost(post: Post)
}

extension PostEndPoint: EndPointType {
    
    var path: String {
        switch self {
        case .createPost:
            return "/posts"
        }
    }
    
    var baseURL: String {
        switch self {
        case .createPost:
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
        case .createPost:
            return .post
        }
    }
    
    var body: Encodable? {
        switch self {
        case .createPost(let post):
            return post
        }
    }
    
    var parameters: [String : String] {
        switch self {
        case .createPost:
            return [:]
        }
    }
    
    var headers: [String : String]? {
        APIManager.commonHeaders
    }
}


