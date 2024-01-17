import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(0..<100) { _ in
                    FeedCell()
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    FeedView()
}
