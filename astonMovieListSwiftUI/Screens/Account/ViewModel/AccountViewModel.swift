import Foundation

class AccountViewModel: ObservableObject {
    
    @Published var login: String = ""
    @Published var password: String = ""
    @Published var validDescription: String = ""
    @Published var hasError: Bool = false
    
    func checkValidation() {
        guard login != "" else {
            validDescription = Constant.emptyLogin.localized()
            hasError = true
            return
        }
        guard password != "" else {
            validDescription = Constant.emptyPassword.localized()
            hasError = true
            return
        }
        guard login == "Hudihka" else {
            validDescription = Constant.incorrectLogin.localized()
            hasError = true
            return
        }
        guard password == "1234" else {
            validDescription = Constant.incorrectPassword.localized()
            hasError = true
            return
        }
        hasError = false
        success()
    }
    
    func success() {
        print("success")
    }
}

// MARK: - Constant's

extension AccountViewModel {
    struct Constant {
        static let emptyLogin = "accountViewModel.emptyLogin"
        static let emptyPassword = "accountViewModel.emptyPassword"
        static let incorrectLogin = "accountViewModel.incorrectLogin"
        static let incorrectPassword = "accountViewModel.incorrectPassword"
    }
}

