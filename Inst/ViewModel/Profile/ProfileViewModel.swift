import SwiftUI

final class ProfileViewModel: ObservableObject {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func follow() {
        UserService.follow(id: user.id) { error in
            print("Success")
        }
    }
    
    func unFollow() {
        
    }
    
    func checkIfUserIsFollowed() {
        
    }
}
