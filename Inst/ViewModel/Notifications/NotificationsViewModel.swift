import SwiftUI
import Firebase

final class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    static let notificationsCollection = "user-notifications"
    
    init() {
        fetchNotification()
    }
}

extension NotificationsViewModel {
    func fetchNotification() {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        let query = COLLECTION_NOTIFICATIONS.document(user.id)
            .collection(NotificationsViewModel.notificationsCollection)
            .order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.notifications = documents.compactMap({
                try? $0.data(as: Notification.self)
            })
        }
    }
    
    static func uploadNotifications(to userId: String, type: NotificationType, post: Post? = nil) {
        guard let user = AuthViewModel.shared.currentUser,
              userId != user.id else { return }
        let id = NSUUID().uuidString.lowercased()
        let notification = Notification(
            id: id, postId: post?.id, userId: user.id,
            username: user.nickname, avatar: user.avatar,
            timestamp: Timestamp(date: Date()), type: type
        )
        let data = notification.data
        
        COLLECTION_NOTIFICATIONS.document(userId)
            .collection(NotificationsViewModel.notificationsCollection)
            .addDocument(data: data)
    }
}
