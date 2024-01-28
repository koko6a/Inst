import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    
    let placeholder: Text
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                
                TextField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        placeholder.foregroundStyle(.white.opacity(0.8))
                    }
            }
            .padding(.leading, 8)
            .frame(minHeight: 44)
            .background(.white.opacity(0.15))
            .clipShape(.rect(cornerRadius: 10))
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    CustomTextField(text: .constant(""), placeholder: Text("Email"), imageName: "envelope")
}
