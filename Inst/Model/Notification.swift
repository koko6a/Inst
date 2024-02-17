import Foundation
import Firebase

struct Notification: Identifiable, Codable {
    let id: String
    var postId: String?
    let userId: String
    let username: String
    let avatar: String
    let timestamp: Timestamp
    let type: NotificationType
    
    var isFollowed: Bool? = false
    var post: Post?
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        case id, username, avatar, timestamp, type
        case postId = "post_id"
        case userId = "user_id"
    }
}

enum NotificationType: Int, Codable, CaseIterable {
    case like = 0
    case comment = 1
    case follow = 2
    
    var message: String {
        switch self {
        case .like:
            " liked one of your posts."
        case .comment:
            " commented one of your posts."
        case .follow:
            " started following you."
        }
    }
}

extension Notification {
    var data: [String: Any] {
        var fields: [String: Any] = [
            "id": id,
            "user_id": userId,
            "username": username,
            "avatar": avatar,
            "type": type.rawValue,
            "timestamp": timestamp,
        ]
        if let postId {
            fields["post_id"] = postId
        }
        
        return fields
    }
}
