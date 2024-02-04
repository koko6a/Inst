import SwiftUI
import Firebase

extension CommentViewModel {
    enum Collection: String {
        case postComments = "post_comments"
    }
}

final class CommentViewModel: ObservableObject {
    @Published var comments = [Comment]()
    private let post: Post
    
    init(post: Post) {
        self.post = post
        fetchComments()
    }
}

extension CommentViewModel {
    func sendComment(content: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        let commentId = NSUUID().uuidString.lowercased()
        
        let comment = Comment(
            id: commentId, content: content,
            postOwnerId: post.ownerId, avatar: user.avatar,
            timestamp: Timestamp(date: Date()),
            authorId: user.id, username: user.nickname
        )
        
        let data = comment.data
        
        COLLECTION_POSTS.document(post.id)
            .collection(Collection.postComments.rawValue)
            .document(commentId).setData(data) { error in
                if let error {
                    print(error)
                    return
                }
            }
    }
    
    func fetchComments() {
        let collection = COLLECTION_POSTS.document(post.id)
            .collection(Collection.postComments.rawValue)
            .order(by: "timestamp", descending: true)
        
        collection.addSnapshotListener { snapshot, _ in
            guard let addedDocks = snapshot?.documentChanges
                .filter({ $0.type == .added}) else { return }
            self.comments.append(contentsOf: addedDocks.compactMap({
                try? $0.document.data(as: Comment.self)
            }))
//            self.comments = addedDocks.compactMap({ doc -> Comment? in
//                try? doc.document.data(as: Comment.self)
//            })
        }
    }
}
//            snapshot?.documentChanges.forEach({ change in
//                if change.type == .added {
//                    guard let comment = try? change.document
//                        .data(as: Comment.self) else { return }
//                    self.comments.append(comment)
//                }
//            })

//            .getDocuments { snapshot, _ in
//                guard let data = snapshot?.documents else { return }
//                self.comments = data.compactMap({ doc -> Comment? in
//                    try? doc.data(as: Comment.self)
//                })
//                print(self.comments)
//            }
