import SwiftUI

struct MoreSubsView: View {
    
    var body: some View {
        
        VStack {
            Text("More subscribtions")
                .font(.custom(customFont, size: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("BGColor").ignoresSafeArea())
        
    }
}

struct MoreSubsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreSubsView()
    }
}
