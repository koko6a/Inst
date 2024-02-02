import Foundation

struct User: Codable, Identifiable {
    let id: String
    let avatar: String
    let email: String
    let nickname: String
    let fullName: String
    
    var isCurrent: Bool {
        AuthViewModel.shared.userSession?.uid == id
    }
}
