import SwiftUI

extension View {
    
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}

// extending view to get screen side

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
