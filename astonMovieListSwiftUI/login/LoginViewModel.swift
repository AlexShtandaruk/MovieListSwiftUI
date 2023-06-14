import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    
    // MARK: - View properties
    
    @Published var mobNumber: String = ""
    @Published var otpCode: String = ""
    
    @Published var clientCode: String = ""
    @Published var showOTPField: Bool = false
    
    // MARK: - Error properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK: - Firebase API's
    func getOTPCode() {
        Task {
            do {
                // MARK: - Disable it when testing with Real Device
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                let code = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(mobNumber)", uiDelegate: nil)
                await MainActor.run(body: {
                    clientCode = code
                })
            }
            catch {
               await handlingError(error: error)
            }
        }
    }
    
    func verifyOTPCode() {
        Task {
            do {
                
            }
            catch {
                await handlingError(error: error)
            }
        }
    }
    
    // MARK: - Handlign error
    
    func handlingError(error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

