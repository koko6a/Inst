import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: viewModel.user.avatar))
                    .resizable()
                    .placeholder({ ProgressView() })
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(.circle)
                    .padding(.leading)
                
                Spacer()
                
                UserStatView(value: 10, title: "Post")
                UserStatView(value: 7, title: "Followers")
                UserStatView(value: 51, title: "Following")
                
                Spacer()
                
            }
            
            Text(viewModel.user.fullName)
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top])
            
            Text("iOS developer SwiftUI")
                .font(.system(size: 15))
                .padding(.leading)
                .padding(.top, 2)
            
            ProfileEditButton(viewModel: viewModel)
                .padding(.top, 16)
                .padding(.horizontal, 24)
        }
    }
}
