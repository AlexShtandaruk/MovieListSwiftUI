import Foundation

enum StatusCode {
    
    case information
    case success
    case resursive
    case authError
    case clientError
    case serverError
    
    static func returnResult(for code: Int) -> StatusCode {
        switch code {
        case (100 ... 199):
            return .information
        case (200 ... 299):
            return .success
        case (300 ... 399):
            return .resursive
        case (400 ... 400):
            return .authError
        case (401 ... 499):
            return .clientError
        case (500 ... 599):
            return .serverError
        default:
            return .serverError
        }
    }
}
