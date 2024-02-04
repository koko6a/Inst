import Foundation
import Firebase

struct Comment: Identifiable, Codable {
    let id: String
    let content: String
    let postOwnerId: String
    let avatar: String
    let timestamp: Timestamp
    let authorId: String
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case id, content, avatar, timestamp, username
        case postOwnerId = "post_owner_id"
        case authorId = "author_id"
    }
}

extension Comment {
    var data: [String: Any] {
        return [
            "id": id,
            "content": content,
            "post_owner_id": postOwnerId,
            "avatar": avatar,
            "timestamp": timestamp,
            "author_id": authorId,
            "username": username
        ]
    }
}
