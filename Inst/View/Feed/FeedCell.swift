import SwiftUI
import Kingfisher

struct FeedCell: View {
    @ObservedObject var viewModel: FeedCellViewModel
    
    private var isLiked: Bool {
        return viewModel.post.didLike ?? false
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: viewModel.post.avatarUrl))
                    .resizable()
                    .placeholder({ ProgressView() })
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipShape(.rect(cornerRadius: 18))
                    .clipped()
                
                Text(viewModel.post.username)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding([.leading, .bottom], 8)
            
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .placeholder({ ProgressView() })
                .frame(maxHeight: 440)
            
            HStack(spacing: 16) {
                Button {
                    self.isLiked ? viewModel.unlike() : viewModel.like()
                } label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(isLiked ? .red : .black)
                        .font(.system(size: 20))
                        .tint(isLiked ? .red : .clear)
                        .padding(4)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                }
            }
            .padding(.leading, 4)
            
            Text(viewModel.likeString)
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 2)
            
            HStack {
                Text(viewModel.post.username)
                    .font(.system(size: 14, weight: .semibold)) +
                Text(" " + viewModel.post.caption)
                    .font(.system(size: 15))
            }
            .padding(.horizontal, 8)
            
            Text("2d")
                .font(.system(size: 14))
                .foregroundStyle(.gray)
                .padding(.leading, 8)
                .padding(.top, 2)
        }
    }
}
