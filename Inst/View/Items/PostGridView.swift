import SwiftUI

struct PostGridView: View {
    private let items = [GridItem(), GridItem(), GridItem()]
    private let size = UIScreen.main.bounds.width / 3
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 2, content: {
            ForEach(0..<36) { _ in
                NavigationLink {
                    FeedView()
                } label: {
                    Image("img6")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipped()
                }

            }
        })
    }
}

#Preview {
    PostGridView()
}
