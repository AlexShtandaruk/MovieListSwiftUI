import Foundation

class ConfigManager {
    
    static let shared = ConfigManager()
    
    lazy var router: Router = {
        return Router()
    }()
}
