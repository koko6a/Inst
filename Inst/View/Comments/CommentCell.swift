import SwiftUI
import Kingfisher

struct CommentCell: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            KFImage(URL(string: comment.avatar))
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
            Text(comment.username)
                .font(.system(size: 14, weight: .semibold)) + Text(" \(comment.content)")
                .font(.system(size: 14))
            
            Spacer()
            
            Text("2m")
                .foregroundStyle(.gray)
                .font(.system(size: 12))
                .padding(.trailing)
        }
    }
}
