import SwiftUI

@main
struct astonMovieListSwiftUIApp: App {
    
    private var configurator: Configurator? = nil
    
    @AppStorage("logStatus") var logStatus: Bool = false
    
    init() {
        configurate()
        logStatus = false
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    mutating func configurate() {
        self.configurator = Configurator()
        self.configurator?.register()
    }
}
