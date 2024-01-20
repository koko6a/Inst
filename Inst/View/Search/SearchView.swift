import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var inSearchMode = false
    var body: some View {
        ScrollView {
            SearchBar(text: $text, isEditing: $inSearchMode)
                .padding()
            
            ZStack {
                if inSearchMode {
                    UserListView()
                } else {
                    PostGridView()
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
