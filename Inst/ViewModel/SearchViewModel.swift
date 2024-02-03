import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.users = documents.compactMap({ query -> User? in
                return try? query.data(as: User.self)
            })
        }
    }
    
    func filterUsers(_ query: String) -> [User] {
        users.filter({ $0.fullName.lowercased().contains(query.lowercased()) ||
            $0.nickname.lowercased().contains(query.lowercased())
        })
    }
}
