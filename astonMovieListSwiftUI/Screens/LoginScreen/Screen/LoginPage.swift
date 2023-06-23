import SwiftUI

struct LoginPage: View {
    
    @StateObject var viewModel: LoginPageViewModel = .init()
    
    var body: some View {
        
        VStack {
            //welcome back text for 3 half of the screen
            Text("Welcome\nback")
                .font(.custom(customFont, size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 3.5 )
                .padding()
                .background(
                    ZStack {
                        //Gradient circle
                        LinearGradient(
                            colors: [Color.pink.opacity(0.2), Color.pink.opacity(0.8)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing)
                        .offset(y: -25)
                        .ignoresSafeArea()
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 3)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(30)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.leading, 30)
                    }
                )
            
            ScrollView(.vertical, showsIndicators: false) {
                //login page
                VStack(spacing: 15) {
                    Text(viewModel.registerUser ? "Register" : "Login")
                        .font(.custom(customFont, size: 22))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //Custom text field
                    customTextField(
                        title: "Email",
                        icon: "envelope",
                        hint: "example@gmail.com",
                        value: $viewModel.email,
                        showPassword: .constant(false)
                    )
                    .padding(.top, 30)
                    
                    customTextField(
                        title: "Password",
                        icon: "lock",
                        hint: "123456",
                        value: $viewModel.password,
                        showPassword: $viewModel.showEnterPassword
                    )
                    .padding(.top, 30)
                    
                    //register reenter password
                    if viewModel.registerUser {
                        customTextField(
                            title: "Repeat Password",
                            icon: "lock",
                            hint: "123456",
                            value: $viewModel.repeatPassword,
                            showPassword: $viewModel.showReEnterPassword
                        )
                        .padding(.top, 30)

                    }
                    
                    //forgot password button
                    Button {
                        viewModel.forgotPassword()
                    } label: {
                        Text("Forgot password?")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.indigo)
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //login button
                    Button {
                        if viewModel.registerUser {
                            viewModel.register()
                        } else {
                            viewModel.login()
                        }
                       
                    } label: {
                        Text("Login")
                            .font(.custom(customFont, size: 17))
                            .fontWeight(.bold)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.indigo)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07),radius: 5, x: 5, y: 5)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    //register user
                    Button {
                        withAnimation {
                            viewModel.registerUser.toggle()
                        }
                    } label: {
                        Text(viewModel.registerUser ? "Back to login" : "Create account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.indigo)
                    }
                    .padding(.top, 8)
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                //appling custom corner
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.indigo)
        .toolbar(.hidden, for: .tabBar)
        
        //clearing data when changes
        .onChange(of: viewModel.registerUser) { newValue in
            viewModel.email = ""
            viewModel.password = ""
            viewModel.repeatPassword = ""
            viewModel.showEnterPassword = false
            viewModel.showReEnterPassword = false
        }
    }
    
    @ViewBuilder
    func customTextField(title: String,  icon: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        
        //show button
        .overlay(
            Group {
                if title.contains("Password") {
                    Button(action: { showPassword.wrappedValue.toggle() }) {
                        Text( showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13))
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                    }
                }
            }
            , alignment: .trailing)
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
