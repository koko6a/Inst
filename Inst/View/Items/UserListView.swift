import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: SearchViewModel
    @Binding var searchText: String
    
    private var users: [User] {
        searchText.isEmpty ? viewModel.users : viewModel.filterUsers(searchText)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    NavigationLink {
                        ProfileView(user: user)
                    } label: {
                        UserCell(user: user)
                           .padding(.leading)
                    }

                }
            }
        }
    }
}
