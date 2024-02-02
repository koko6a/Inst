import SwiftUI

struct ProfileEditButton: View {
    @ObservedObject var viewModel: ProfileViewModel
    var isFollow = false
    
    var body: some View {
        if viewModel.user.isCurrent {
            Button {
                
            } label: {
                Text("Edit Profile")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 32)
                    .overlay {
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1)
                    }
            }
        } else {
            HStack {
                Button {
                    isFollow ? viewModel.unFollow() : viewModel.follow()
                } label: {
                    Text(isFollow ? "Following" : "Follow")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity, minHeight: 32)
                        .foregroundStyle(isFollow ? .black : .white)
                        .background(isFollow ? .clear : .blue)
                        .overlay {
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: isFollow ? 1 : 0)
                        }
                }.clipShape(.rect(cornerRadius: 4))
                
                Button {
                    
                } label: {
                    Text("Message")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity, minHeight: 32)
                        .overlay {
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                }
            }
        }
    }
}
