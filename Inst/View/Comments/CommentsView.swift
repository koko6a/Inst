import SwiftUI

struct CommentsView: View {
    @ObservedObject var viewModel: CommentViewModel
    @State var commentText = ""
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
                    }
                }.padding()
            }.onTapGesture {
                UIApplication.shared.endEditing()
            }
            
            CommentInputView(inputText: $commentText, action: sendComment)
        }
    }
    
    private func sendComment() {
        viewModel.sendComment(content: commentText)
        commentText = ""
        UIApplication.shared.endEditing()
    }
}
