import SwiftUI

struct CommentInputView: View {
    @Binding var inputText: String
    var action: () -> Void
    
    private var isEnabled: Bool {
        !inputText.isEmpty
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundStyle(.separator)
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
            
            HStack {
                TextField("Comment...", text: $inputText)
                    .textFieldStyle(.plain)
                    .frame(minHeight: 30)
                    .autocorrectionDisabled()
                
                Button(action: action) {
                    Text("Send")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(isEnabled ? .blue : .gray)
                }.disabled(!isEnabled)
                
            }
            .padding(.horizontal)
            .padding(.top, 4)
        }
    }
}
