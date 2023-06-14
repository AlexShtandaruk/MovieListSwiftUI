import Foundation

class Configurator {
    
    func register() {
        ServiceLocator.shared.addServices(service: Networking())
        ServiceLocator.shared.addServices(service: DataCaretaker())
    }
}
