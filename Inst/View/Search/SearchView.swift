import SwiftUI

struct SearchView: View {
    @State var text = ""
    var body: some View {
        ScrollView {
            SearchBar(text: $text)
                .padding()
            PostGridView()
        }
    }
}

#Preview {
    SearchView()
}
