import SwiftUI

struct UserListView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<20) { _ in
                    NavigationLink {
                        ProfileView()
                    } label: {
                        UserCell()
                           .padding(.leading)
                    }

                }
            }
        }
    }
}

#Preview {
    UserListView()
}
