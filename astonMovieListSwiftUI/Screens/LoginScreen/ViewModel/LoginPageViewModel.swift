import SwiftUI

final class LoginPageViewModel: ObservableObject {
    
    //login properties
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    //register properties
    @Published var registerUser: Bool = false
    @Published var repeatPassword: String = ""
    @Published var showEnterPassword: Bool = false
    @Published var showReEnterPassword: Bool = false
    
    //log status
    @AppStorage("logStatus") var logStatus: Bool = false
    
    //login call
    
    func login() {
        withAnimation {
            logStatus = true
        }
    }
    
    func register() {
        withAnimation {
            logStatus = true
        }
    }
    
    func forgotPassword() {
        
    }

}
