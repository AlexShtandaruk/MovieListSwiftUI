import SwiftUI

@main
struct astonMovieListSwiftUIApp: App {
    
    private var configurator: Configurator? = nil
    
    init() { configurate() }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(ConfigManager.shared.router)
        }
    }
    
    mutating func configurate() {
        self.configurator = Configurator()
        self.configurator?.register()
    }
}
