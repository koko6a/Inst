import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .clipShape(.rect(cornerRadius: 8))
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
                .onTapGesture {
                    withAnimation(.spring) {
                        isEditing = true
                    }
                }
            
            if isEditing {
                Button {
                    withAnimation(.spring) {
                        isEditing = false
                        text = ""
                        UIApplication.shared.endEditing()
                    }
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing, 8)
                //.transition(.move(edge: .trailing))
            }
        }
    }
}

#Preview {
    SearchBar(text: .constant("Search..."), isEditing: .constant(false))
}
