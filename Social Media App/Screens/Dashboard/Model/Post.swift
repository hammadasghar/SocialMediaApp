import Foundation

class Post: Codable {
    let postId: Int?
    let title: String?
    let body: String?
    var likes: Int?
    var comments: Int?
    let user: User?
    var isLiked: Bool?

    private enum CodingKeys: String, CodingKey {
        case postId
        case title
        case body
        case likes
        case isLiked
        case comments
        case user
    }
    
    init(postId: Int?, title: String?, body: String?, likes: Int?, isLiked: Bool? = nil, comments: Int?, user: User?) {
        self.postId = postId
        self.title = title
        self.body = body
        self.likes = likes
        self.isLiked = isLiked
        self.comments = comments
        self.user = user
    }
}

