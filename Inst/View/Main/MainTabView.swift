import SwiftUI

struct MainTabView: View {
    @Binding var selectedIndex: Int
    
    let user: User
    
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Feed"
        case 1: return "Search"
        case 2: return "New Post"
        case 3: return "Notifications"
        case 4: return "Profile"
        default: return ""
        }
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedIndex) {
                FeedView()
                    .onTapGesture {
                        selectedIndex = 0
                    }.tag(0)
                
                    .tabItem {
                        Image(systemName: "house")
                    }
                
                SearchView()
                    .onTapGesture {
                        selectedIndex = 1
                    }.tag(1)
                
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                UploadPostView(tabIndex: $selectedIndex)
                    .onTapGesture {
                        selectedIndex = 2
                    }.tag(2)
                
                    .tabItem {
                        Image(systemName: "plus.square")
                    }
                
                NotificationsView()
                    .onTapGesture {
                        selectedIndex = 3
                    }.tag(3)
                
                    .tabItem {
                        Image(systemName: "heart")
                    }
                
                ProfileView(user: user)
                    .onTapGesture {
                        selectedIndex = 4
                    }.tag(4)
                
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
            .navigationTitle(tabTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        AuthViewModel.shared.logOut()
                    } label: {
                        Text("Logout")
                    }
                }
            }
        }
    }
}
