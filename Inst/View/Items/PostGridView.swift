import SwiftUI
import Kingfisher

struct PostGridView: View {
    @ObservedObject var viewModel: PostGridViewModel
    private let items = [GridItem(), GridItem(), GridItem()]
    private let size = UIScreen.main.bounds.width / 3
    
    init(postsType: PostFilterType) {
        self.viewModel = PostGridViewModel(with: postsType)
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 2, content: {
            ForEach(viewModel.posts) { post in
                NavigationLink {
                    let viewModel = FeedCellViewModel(post: post)
                    FeedCell(viewModel: viewModel)
                } label: {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .placeholder({ ProgressView() })
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipped()
                }

            }
        })
    }
}
