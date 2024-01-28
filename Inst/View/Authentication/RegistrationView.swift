import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var selectedImage: UIImage?
    @State private var postImage: Image?
    @State private var imagePickerPresented = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.purple, Color.blue],
                startPoint: .top, endPoint: .bottom
            ).ignoresSafeArea()
                            
            VStack {
                Spacer()
                
                Button {
                    imagePickerPresented.toggle()
                } label: {
                    if let postImage {
                        postImage
                            .resizable()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .scaledToFill()
                    } else {
                        Image("addPhoto")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                    }
                }.sheet(isPresented: $imagePickerPresented, onDismiss: {
                    guard let selectedImage else { return }
                    postImage = Image(uiImage: selectedImage)
                }, content: {
                    ImagePicker(image: $selectedImage)
                })

                Spacer()
                
                VStack(spacing: 24) {
                    
                    CustomTextField(
                        text: $email, placeholder: Text("Email"),
                        imageName: "envelope"
                    )
                    
                    CustomTextField(
                        text: $firstName, placeholder: Text("First Name"),
                        imageName: "envelope"
                    )
                    
                    CustomTextField(
                        text: $lastName, placeholder: Text("Last Name"),
                        imageName: "envelope"
                    )
                    
                    CustomSecureTextField(
                        text: $password, placeholder: Text("Password"))
                    
                }.padding(.horizontal, 24)
            
                Button {
                    viewModel.register()
                } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundStyle(.white)
                        .background(Color("violetPrimary"))
                        .clipShape(Capsule())
                }.padding(24)
                
                Spacer()
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                    }.foregroundStyle(.white)
                }
            }
        }
    }
}
