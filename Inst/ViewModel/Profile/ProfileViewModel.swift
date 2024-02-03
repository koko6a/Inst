import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
    }
    
    func follow() {
        UserService.follow(id: user.id) { error in
            self.user.isFollowed = true
        }
    }
    
    func unFollow() {
        UserService.unFollow(id: user.id) { error in
            self.user.isFollowed = false
        }
    }
    
    func checkIfUserIsFollowed() {
        guard !user.isCurrent else { return }
        UserService.checkIfUserIsFollowed(id: user.id) { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
}
