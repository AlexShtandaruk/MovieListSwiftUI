import SwiftUI

struct ML: View {
    var body: some View {
        VStack {
            HStack {
                Button {} label: {
                    Image(systemName: "star")
                        .font(.title2)
                        .foregroundColor(.primary)
                }

                Spacer()
                Button {} label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }
            .padding()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ML()
    }
}
