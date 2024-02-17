import SwiftUI
import Kingfisher

struct NotificationCell: View {
    @State private var showPostImage = false
    @ObservedObject var viewModel: NotificationCellViewModel
    
    var isFollowed: Bool {
        viewModel.notification.isFollowed ?? false
    }
    
    init(notification: Notification) {
        self.viewModel = NotificationCellViewModel(notification: notification)
    }
    
    var body: some View {
        HStack {
            if let user = viewModel.notification.user {
                NavigationLink {
                    ProfileView(user: user)
                } label: {
                    KFImage(URL(string: viewModel.notification.avatar))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                }
            }
            
            Text(viewModel.notification.username)
                .font(.system(size: 14, weight: .semibold)) +
            Text(viewModel.notification.type.message)
                .font(.system(size: 15)) +
            Text(" \(viewModel.timeStampString)")
                .font(.system(size: 12))
                .foregroundStyle(.gray)
            
            Spacer()
            
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post {
                    let viewModel = FeedCellViewModel(post: post)
                    NavigationLink {
                        FeedCell(viewModel: viewModel)
                    } label: {
                        KFImage(URL(string: post.imageUrl))
                            .placeholder({ ProgressView() })
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .clipped()
                    }
                }
            } else {
                Button {
                    isFollowed ? viewModel.unFollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "Following": "Follow")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 3))
                        .font(.system(size: 14, weight: .semibold))
                }

            }
            
        }.padding(.horizontal)
    }
}
