import SwiftUI

extension FeedCellViewModel {
    enum PropertyField: String {
        case postLikes = "post-likes"
        case userLikes = "user-likes"
        case likes
    }
}

final class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    var likeString: String {
        let string = post.likes > 0 ? "likes" : "like"
        return "\(post.likes) " + string
    }
    
    var timeStampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let date = post.timeStamp.dateValue()
        return formatter.string(from: date, to: Date()) ?? ""
    }
    
    private var userId: String {
        AuthViewModel.shared.userSession?.uid ?? ""
    }
        
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
    }
    
    func like() {
        COLLECTION_POSTS.document(post.id)
            .collection(PropertyField.postLikes.rawValue)
            .document(userId).setData([:]) { _ in
                COLLECTION_USERS.document(self.userId)
                    .collection(PropertyField.userLikes.rawValue)
                    .document(self.post.id).setData([:]) { _ in
                        COLLECTION_POSTS.document(self.post.id)
                            .updateData([
                                PropertyField.likes.rawValue : self.post.likes + 1
                            ])
                        
                        NotificationsViewModel.uploadNotifications(
                            to: self.post.ownerId, type: .like, post: self.post
                        )
                        
                        self.post.didLike = true
                        self.post.likes += 1
                    }
            }
    }
    
    func unlike() {
        guard post.likes > 0 else { return }
        COLLECTION_POSTS.document(post.id)
            .collection(PropertyField.postLikes.rawValue)
            .document(userId).delete { _ in
                COLLECTION_USERS.document(self.userId)
                    .collection(PropertyField.userLikes.rawValue)
                    .document(self.post.id).delete { _ in
                        COLLECTION_POSTS.document(self.post.id)
                            .updateData([PropertyField.likes.rawValue : self.post.likes - 1])
                        
                        self.post.didLike = false
                        self.post.likes -= 1
                    }
            }
    }
    
    func checkIfUserLikedPost() {
        COLLECTION_USERS.document(userId)
            .collection(PropertyField.userLikes.rawValue).document(post.id)
            .getDocument { snapshot, _ in
                guard let isLiked = snapshot?.exists else { return }
                self.post.didLike = isLiked
            }
    }
}
