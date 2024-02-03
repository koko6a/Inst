import Foundation
import Firebase

extension UserService {
    enum Collection: String {
        case following = "user-following"
        case followers = "user-followers"
    }
}

typealias ErrorCompletion = ((Error?) -> Void)?

struct UserService {
    static func follow(id: String, completion: ErrorCompletion) {
        guard let currentId = AuthViewModel.shared.userSession?.uid else {
            return
        }
        
        COLLECTION_FOLLOWING.document(currentId)
            .collection(Collection.following.rawValue)
            .document(id).setData([:]) { _ in
                COLLECTION_FOLLOWERS.document(id)
                    .collection(Collection.followers.rawValue)
                    .document(currentId).setData([:], completion: completion )
            }
    }
    
    static func unFollow(id: String, completion: ErrorCompletion) {
        guard let currentId = AuthViewModel.shared.userSession?.uid else {
            return
        }
        
        COLLECTION_FOLLOWING.document(currentId)
            .collection(Collection.following.rawValue).document(id).delete { _ in
                COLLECTION_FOLLOWERS.document(id)
                    .collection(Collection.followers.rawValue)
                    .document(currentId).delete(completion: completion)
            }
    }
    
    static func checkIfUserIsFollowed(id: String, completion: @escaping (Bool) -> Void) {
        guard let currentId = AuthViewModel.shared.userSession?.uid else {
            return
        }
        
        COLLECTION_FOLLOWING.document(currentId)
            .collection(Collection.following.rawValue)
            .document(id).getDocument { snapshot, _ in
                guard let isFollowed = snapshot?.exists else { return }
                completion(isFollowed)
            }
    }
}
