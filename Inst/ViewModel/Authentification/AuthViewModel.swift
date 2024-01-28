import SwiftUI
import Firebase
import FirebaseAuth

final class AuthViewModel {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
}

extension AuthViewModel: ObservableObject {
    func login() {
        print(#function)
    }
    
    func register() {
        print(#function)
    }
}
