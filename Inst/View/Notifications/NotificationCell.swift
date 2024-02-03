import SwiftUI

struct NotificationCell: View {
    @State private var showPostImage = false
    
    var body: some View {
        HStack {
            Image("koko6a")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            Text("Koko6a")
                .font(.system(size: 14, weight: .semibold)) +
            Text(" liked one of your posts")
                .font(.system(size: 15))
            
            Spacer()
            
            if showPostImage {
                Image("koko6a")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
            } else {
                Button {
                    
                } label: {
                    Text("Follow")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                        .font(.system(size: 14, weight: .semibold))
                }

            }
            
        }.padding(.horizontal)
    }
}

#Preview {
    NotificationCell()
}
