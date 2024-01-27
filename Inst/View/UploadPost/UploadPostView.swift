import SwiftUI

struct UploadPostView: View {
    @State private var selectedImage: UIImage?
    @State private var postImage: Image?
    @State var visibleImage = Image("addPhoto")
    @State private var captionText = ""
    @State private var imagePickerPresented = false
    
    private var isDisabled: Bool {
        postImage == nil
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Button {
                    imagePickerPresented.toggle()
                } label: {
                    visibleImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipped()
                }
                .sheet(isPresented: $imagePickerPresented, onDismiss: {
                    if let selectedImage {
                        postImage = Image(uiImage: selectedImage)
                        visibleImage = postImage!
                    }
                }, content: {
                    ImagePicker(image: $selectedImage)
                })
                
                ZStack(alignment: .topLeading) {
                     
                    TextEditor(text: $captionText)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .strokeBorder(style: .init(lineWidth: 1))
                                .foregroundStyle(.secondary)
                        )
                        .frame(maxHeight: 120)
                        .disabled(isDisabled)
                    
                    if captionText.isEmpty {
                        Text(isDisabled ? "Pick your image" : "Enter a caption")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.secondary)
                            .padding(.leading, 4)
                            .padding(.top, 8)
                    }
                }
                                    
            }.padding()
            
            Button {
                
            } label: {
                Text("Share")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(isDisabled ? .gray : .blue)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 5))
                    .padding(.horizontal, 24)
                    .disabled(isDisabled)
            }
        }
    }
}

#Preview {
    UploadPostView()
}
