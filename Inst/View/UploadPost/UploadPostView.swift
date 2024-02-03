import SwiftUI

struct UploadPostView: View {
    @State private var selectedImage: UIImage?
    @State private var postImage: Image?
    @State var visibleImage = Image("addPhoto")
    @State private var captionText = ""
    @State private var imagePickerPresented = false
    @Binding var tabIndex: Int
    @ObservedObject var viewModel = UploadPostViewModel()
    
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
            
            HStack {
                Button {
                    guard let selectedImage else { return }
                    viewModel.uploadPost(caption: captionText,
                                         image: selectedImage) { error in
                        clearPost(showFeed: true)
                    }
                } label: {
                    Text("Share")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(isDisabled ? .gray : .blue)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 5))
                        .disabled(isDisabled)
                }
                
                Button {
                    clearPost(showFeed: false)
                } label: {
                    Text("Cancel")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(isDisabled ? .gray : .red)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 5))
                        .disabled(isDisabled)
                }
            }.padding(.horizontal, 16)
        }
    }
    
    private func clearPost(showFeed: Bool) {
        captionText = ""
        postImage = nil
        selectedImage = nil
        visibleImage = Image("addPhoto")
        if showFeed {
            tabIndex = 0
        }
    }
}
