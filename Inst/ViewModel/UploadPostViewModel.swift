import SwiftUI
import Firebase

final class UploadPostViewModel: ObservableObject {
    func uploadPost(caption: String, image: UIImage, completion: ErrorCompletion) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        FirestoreImageUploader.uploadImage(image: image, type: .post) { url in
            let id = NSUUID().uuidString.lowercased()
            let post = Post(
                id: id, ownerId: user.id, username: user.nickname,
                avatarUrl: user.avatar, caption: caption,
                timeStamp: Timestamp(date: Date()), imageUrl: url, likes: 0
            )
            let data = post.data
            COLLECTION_POSTS.document(id).setData(data, completion: completion)
        }
    }
}
