//import SwiftUI
//
//// MARK: - CustomTabBar
//
//struct CustomTabBar: View {
//    
//    @Binding var selectedTab: String
//    
//    // storing each tab midpoints to animate it in the future...
//    @State var tabPoints: [CGFloat] = []
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            //Tab bar items
//            TabBarItem(
//                image: "house",
//                selectedTab: $selectedTab,
//                tabPoints: $tabPoints
//            )
//            TabBarItem(
//                image: "bookmark",
//                selectedTab: $selectedTab,
//                tabPoints: $tabPoints
//            )
//            TabBarItem(
//                image: "message",
//                selectedTab: $selectedTab,
//                tabPoints: $tabPoints
//            )
//            TabBarItem(
//                image: "person",
//                selectedTab: $selectedTab,
//                tabPoints: $tabPoints
//            )
//        }
//        .padding()
//        .background(Color.white
//            .clipShape(
//                TabCurve(
//                    tabPoint: getCurvePoint() - 15
//                )
//            )
//        )
//        .overlay(
//            Circle()
//                .fill(Color.white)
//                .frame(width: 10, height: 10)
//                .offset(x: getCurvePoint() - 20)
//            , alignment: .bottomLeading
//        )
//        .cornerRadius(30)
//        .padding(.horizontal)
//    }
//    
//    // extracting point...
//    
//    func getCurvePoint() -> CGFloat {
//        
//        // if tabPoint is empty...
//        if tabPoints.isEmpty {
//            return 10
//        } else {
//            switch selectedTab {
//            case "house":
//                return tabPoints[0]
//            case "bookmark":
//                return tabPoints[1]
//            case "message":
//                return tabPoints[2]
//            case "person":
//                return tabPoints[3]
//            default:
//                return tabPoints[0]
//            }
//        }
//    }
//}
//
//struct CustomTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
//
//// MARK: - TabBarItem
//
//struct TabBarItem: View {
//    
//    var image: String
//    @Binding var selectedTab: String
//    @Binding var tabPoints: [CGFloat]
//    
//    var body: some View {
//        
//        // for get mid point of each button for curve animation...
//        GeometryReader { reader -> AnyView in
//            
//            // extracting Midpoint and storing...
//            let midX = reader.frame(in: .global).midX
//            
//            DispatchQueue.main.async {
//                //avoiding junk data...
//                if tabPoints.count <= 4 {
//                    tabPoints.append(midX)
//                }
//            }
//            
//            return AnyView(
//                Button {
//                    //changing tab...
//                    withAnimation(
//                        .interactiveSpring(
//                            response: 0.6,
//                            dampingFraction: 0.5,
//                            blendDuration: 0.5
//                        )
//                    ) {
//                        selectedTab = image
//                    }
//                } label: {
//                    // filing color if its selected
//                    Image(systemName: ("\(image)\(selectedTab == image ? ".fill" : "")"))
//                        .font(.system(size: 25, weight: .semibold))
//                        .foregroundColor(.black)
//                    
//                    //lifting view if its selected...
//                        .offset(y: selectedTab == image ? -10 : 0)
//                }
//                // max frame...
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//            )
//        }
//        // max height...
//        .frame(height: 50)
//        
//    }
//}
