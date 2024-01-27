import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("koko6a")
                    .resizable()
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
            
            Text("Ruslan Koko6a")
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top])
            
            Text("iOS developer SwiftUI")
                .font(.system(size: 15))
                .padding(.leading)
                .padding(.top, 2)
            
            ProfileEditButton()
                .padding(.top, 16)
                .padding(.horizontal, 24)
        }
    }
}

#Preview {
    ProfileHeaderView()
}
