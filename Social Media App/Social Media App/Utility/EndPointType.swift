//
//  EndPointType.swift
//  Social Media App
//
//  Created by Syed Hammad on 12/05/2024.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var urlComponent: URLComponents? { get }
    var parameters: [String : String] { get }
    var method: HTTPMethods { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
}
