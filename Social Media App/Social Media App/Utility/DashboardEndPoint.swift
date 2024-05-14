//
//  DashboardEndPoint.swift
//  Social Media App
//
//  Created by Syed Hammad on 12/05/2024.
//

import Foundation

enum DashboardEndPoint {
    case posts
    case likePost(postId: Int)
}

extension DashboardEndPoint: EndPointType {

    
    
    var path: String {
        switch self {
        case .posts:
            return "/983db276-2ef7-441c-9c2e-cde5bb4599cf/posts"
        case .likePost(let postId):
            return "/4090048b-5a26-4452-874a-1593b291169f/post/\(postId)/liked"
        }
    }
    
    var baseURL: String {
        switch self {
        case .posts , .likePost:
            return "https://run.mocky.io/v3"
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
        case .posts:
            return .get
        case .likePost:
            return .post
        }
    }
    
    var parameters: [String : String] {
        switch self {
        case .posts:
            return [:]
        case .likePost:
            return [:]
        }
    }
    var body: Encodable? {
        switch self {
        case .posts:
            return nil
        case .likePost:
            return nil
        }
    }
    
    var headers: [String : String]? {
        APIManager.commonHeaders
    }
}
