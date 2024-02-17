import SwiftUI

enum PostFilterType {
    case profile(String)
    case explore
}

final class PostGridViewModel: ObservableObject {
    @Published var posts = [Post]()
    let type: PostFilterType
    
    init(with type: PostFilterType) {
        self.type = type
        fetchPosts(for: type)
    }
    
    func fetchPosts(for filter: PostFilterType) {
        switch filter {
        case .profile(let id):
            fetchProfilePosts(for: id)
        case .explore:
            fetchExplorePosts()
        }
    }
}

private extension PostGridViewModel {
    func fetchExplorePosts() {
        COLLECTION_POSTS.order(by: "likes", descending: true)
            .getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.posts = documents.compactMap({ doc -> Post? in
                return try? doc.data(as: Post.self)
            })
        }
    }
    
    func fetchProfilePosts(for id: String) {
        COLLECTION_POSTS.whereField("ownerId", isEqualTo: id)
            .getDocuments { snapshot, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                self.posts = documents.compactMap({ doc -> Post? in
                    return try? doc.data(as: Post.self)
                }).sorted(by: { $0.timeStamp.dateValue() > $1.timeStamp.dateValue() })
            }
    }
}
