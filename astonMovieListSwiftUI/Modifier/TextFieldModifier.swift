import SwiftUI

struct TextFieldModilfier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .background(.black)
            .accentColor(.red)
            .font(.system(size: 15))
            .frame(height: 30)
            .keyboardType(.emailAddress)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.white)
            })
            .padding(.horizontal, 10)
    }
}
