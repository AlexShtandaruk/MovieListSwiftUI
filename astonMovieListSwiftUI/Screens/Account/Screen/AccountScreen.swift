import SwiftUI

struct AccountScreen: View {
    
    @State var login = ""
    @State var password = ""
    
    @ObservedObject var viewModel: AccountViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack(spacing: 30) {
                    loginTextField
                    passwordTextField
                    logInButton
                    rulesText
                }
                Spacer()
            }
            .background(.black)
            .navigationTitle(Constant.title.localized())
            .navigationBarColor(backgroundColor: .black, titleColor: .white)
        }
        .alert(isPresented: $viewModel.hasError, content: {
            Alert(
                title: Text(Constant.alertTitle.localized()),
                message: Text(viewModel.validDescription),
                dismissButton: .cancel(Text(Constant.alertCancel.localized()))
            )
        })
    }
    
    var loginTextField: some View {
        ZStack(alignment: .center) {
            if login.isEmpty {
                Text(Constant.login.localized())
                    .font(.system(size: 15))
                    .foregroundColor(Color.red.opacity(1))
            }
            TextField("", text: $login)
        }
        .modifierForTextField()
    }
    
    var passwordTextField: some View {
        ZStack(alignment: .center) {
            if password.isEmpty {
                Text(Constant.password.localized())
                    .font(.system(size: 15))
                    .foregroundColor(Color.red.opacity(1))
            }
            TextField("", text: $password)
        }
        .modifierForTextField()
    }
    
    var logInButton: some View {
        Button {
            viewModel.login = login
            viewModel.password = password
            viewModel.checkValidation()
        } label: {
            Image(ProjectConstant.Images.logIn)
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
        }
    }
    
    var rulesText: some View {
        Group {
            Text(Constant.rulesOne.localized())
            + Text(Constant.rulesTwo.localized())
                .underline()
                .italic()
        }
        .multilineTextAlignment(.center)
        .font(.system(size: 15))
        .foregroundColor(.white)
        .lineLimit(2)
        .frame(width: 200)
        .onTapGesture {
            print("Tapped on rulesText")
        }
    }
}

// MARK: - Constant's

extension AccountScreen {
    struct Constant {
        static let title = "accountScreen.title"
        static let alertTitle = "accountScreen.alertTitle"
        static let alertCancel = "accountScreen.alertCancel"
        static let login = "accountScreen.login"
        static let password = "accountScreen.password"
        static let rulesOne = "accountScreen.rulesOne"
        static let rulesTwo = "accountScreen.rulesTwo"
    }
}
