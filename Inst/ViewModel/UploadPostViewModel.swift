import SwiftUI
import Firebase

final class UploadPostViewModel: ObservableObject {
    func uploadPost(caption: String, image: UIImage, completion: ErrorCompletion) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        FirestoreImageUploader.uploadImage(image: image, type: .post) { url in
            let post = Post(
                id: UUID().uuidString, ownerId: user.id, username: user.nickname,
                avatarUrl: user.avatar, caption: caption,
                timeStamp: Timestamp(date: Date()), likes: 0, imageUrl: url
            )
            let data = post.data
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
}
