import SwiftUI

extension View {
    
    func toAnyView() -> AnyView {
        AnyView(self)
    }
    
    func modifierForTextField() -> some View {
        modifier(TextFieldModilfier())
    }
}
