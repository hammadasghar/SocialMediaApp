//
//  CommentViewModel.swift
//  Social Media App
//
//  Created by hammad aghar on 13/05/2024.
//

import Foundation

final class CommentViewModel {
    
    var comments: [Comment] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    
    func fetchComments(postId: Int) {
        APIManager.shared.request(
            modelType: [Comment].self,
            type: CommentEndPoint.comments(postId: postId)) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let comments):
                    self.comments = comments
                    self.eventHandler?(.dataLoaded)
                    
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    func addComment(comment: Comment) {
        APIManager.shared.request(
            modelType: Comment.self,
            type: CommentEndPoint.addComment(comment: comment)) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let comment):
                    self.eventHandler?(.commentAdded(comment: comment))
                    
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
}

extension CommentViewModel {
    
    enum Event {
        case stopLoading
        case dataLoaded
        case error(Error?)
        case commentAdded(comment: Comment)
    }
    
}
