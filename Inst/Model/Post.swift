import Foundation
import Firebase

struct Post: Decodable, Identifiable {
    let id: String
    let ownerId: String
    let username: String
    let avatarUrl: String
    let caption: String
    let timeStamp: Timestamp
    let likes: Int
    let imageUrl: String
}

extension Post {
    var data: [String: Any] {
        return [
            "id": id,
            "caption": caption,
            "timeStamp": timeStamp,
            "likes": likes,
            "imageUrl": imageUrl,
            "ownerId": ownerId,
            "avatarUrl": avatarUrl,
            "username": username
        ]
    }
}
