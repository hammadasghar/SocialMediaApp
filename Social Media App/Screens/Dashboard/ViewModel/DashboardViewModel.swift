//
//  DashboardViewModel.swift
//  Social Media App
//
//  Created by hammad aghar on 13/05/2024.
//

import Foundation

final class DashboardViewModel {

    var posts: [Post] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure

    func fetchPosts() {
        APIManager.shared.request(
            modelType: [Post].self,
            type: DashboardEndPoint.posts) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let posts):
                    self.posts = posts
                    self.eventHandler?(.dataLoaded)
                    
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    func likePost(postId: Int) {
        APIManager.shared.request(
            modelType: StatusModel.self,
            type: DashboardEndPoint.likePost(postId: postId)) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let response):
                    if let status = response.status, status {
                        if (self.posts[postId].isLiked ?? false) {
                            self.posts[postId].likes = (self.posts[postId].likes ?? 1) - 1
                        }
                        else {
                            self.posts[postId].likes = (self.posts[postId].likes ?? 0) + 1
                        }
                        self.posts[postId].isLiked = !(self.posts[postId].isLiked ?? false)
                        self.eventHandler?(.postLiked)
                    }
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }


}

extension DashboardViewModel {

    enum Event {
        case stopLoading
        case dataLoaded
        case error(Error?)
        case postLiked
    }

}
