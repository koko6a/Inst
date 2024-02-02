import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

final class AuthViewModel {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthViewModel()
    
    init() {
        self.userSession = Auth.auth().currentUser
        fetchUser()
    }
}

extension AuthViewModel: ObservableObject {
    func login(with email: String, and password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(
        with email: String, and password: String, image: UIImage,
        fullName: String, nickname: String
    ) {
        FirestoreImageUploader.uploadImage(image: image) { url in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = result?.user else { return }
                self.userSession = user
                
                let params = [
                    "email": email,
                    "fullName": fullName,
                    "nickname": nickname,
                    "avatar": url,
                    "id": user.uid
                ]
                
                COLLECTION_USERS.document(user.uid)
                    .setData(params) { error in
                        if let error {
                            print(error.localizedDescription)
                            return
                        }
                    }
                self.fetchUser()
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchUser() {
        guard let id = userSession?.uid else { return }
        COLLECTION_USERS.document(id)
            .getDocument { snapshot, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                let user = try? snapshot?.data(as: User.self)
                self.currentUser = user
        }
    }
}
