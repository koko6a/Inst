import Foundation
import Firebase

struct UserService {
    static func follow(id: String, completion: ((Error?) -> Void)?) {
        guard let currentId = AuthViewModel.shared.userSession?.uid else {
            return
        }
        
        COLLECTION_FOLLOWING.document(currentId)
            .collection("user-following").document(id).setData([:]) { _ in
                COLLECTION_FOLLOWERS.document(id).collection("user-followers")
                    .document(currentId).setData([:], completion: completion )
            }
    }
    
    static func unFollow() {
        
    }
    
    static func checkIfUserIsFollowed() {
        
    }
}
