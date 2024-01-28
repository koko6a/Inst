import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.purple, Color.blue],
                    startPoint: .top, endPoint: .bottom
                ).ignoresSafeArea()
                                
                VStack {
                    Spacer()
                    
                    Image("instLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: UIScreen.main.bounds.width / 2)

                    Spacer()
                    
                    VStack(spacing: 24) {
                        CustomTextField(
                            text: $email, placeholder: Text("Email"),
                            imageName: "envelope"
                        )
                        
                        CustomSecureTextField(
                            text: $password, placeholder: Text("Password"))
                    }.padding(.horizontal, 24)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Forgot Password?")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.white)
                                .padding(.top)
                                .padding(.trailing, 24)
                        }
                    }
                
                    Button {
                        
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .foregroundStyle(.white)
                            .background(Color("violetPrimary"))
                            .clipShape(Capsule())
                    }.padding(24)
                    
                    Spacer()
                    Spacer()
                    
                    NavigationLink {
                        RegistrationView().navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 14))
                            
                            Text("Sign Up")
                                .font(.system(size: 14, weight: .semibold))
                        }.foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
