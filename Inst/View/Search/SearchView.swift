import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var inSearchMode = false
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView {
            SearchBar(text: $text, isEditing: $inSearchMode)
                .padding()
            
            ZStack {
                if inSearchMode {
                    UserListView(viewModel: viewModel, searchText: $text)
                } else {
                    PostGridView()
                }
            }
        }
    }
}
