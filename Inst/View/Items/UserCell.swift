import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: User
    var body: some View {
        HStack {
            KFImage(URL(string: user.avatar))
                .resizable()
                .placeholder { ProgressView() }
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.nickname)
                    .font(.system(size: 14, weight: .semibold))
                
                Text(user.fullName)
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
    }
}
