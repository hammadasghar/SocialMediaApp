//
//  PostViewModel.swift
//  Social Media App
//
//  Created by hammad aghar on 14/05/2024.
//

import Foundation

final class PostViewModel {

    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure

    func createPost(post: Post) {
        DispatchQueue.main.async {
            self.eventHandler?(.loading)
        }
        APIManager.shared.request(
            modelType: Post.self,
            type: PostEndPoint.createPost(post: post)) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let post):
                    self.eventHandler?(.newPostAdded(post: post))
                    
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }


}

extension PostViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case newPostAdded(post: Post)
    }

}
