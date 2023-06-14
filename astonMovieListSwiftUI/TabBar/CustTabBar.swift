import SwiftUI

// MARK: - Enum views

enum Tab: String, CaseIterable {
    case house
    case bookmark
    case message
    case person
}

// MARK: - CustTabBar

struct CustTabBar: View {
    
    @Binding var selectedTab: Tab
    
    // storing each tab midpoints to animate it in the future...
    @State var tabPoints: [CGFloat] = []
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        HStack(spacing: 0) {
            //Tab bar items
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                // for get mid point of each button for curve animation...
                GeometryReader { reader -> AnyView in
                    // extracting Midpoint and storing...
                    let midX = reader.frame(in: .global).midX
                    DispatchQueue.main.async {
                        //avoiding junk data...
                        if tabPoints.count <= 4 {
                            tabPoints.append(midX)
                        }
                    }
                    return AnyView(
                        Button {
                            //changing tab...
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
                                selectedTab = tab
                            }
                        } label: {
                            // filing color if its selected
                            Image(systemName: (
                                withAnimation {
                                    selectedTab == tab ? fillImage : tab.rawValue
                                })
                            )
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(.black)
                            //scale view if its selected...
                            .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                            //lifting view if its selected...
                            .offset(y: selectedTab == tab ? -10 : 0)
                        }
                        // max frame...
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    )
                }
                // max height...
                .frame(height: 50)
            }
        }
        .padding()
        .background(Color.white
            .clipShape(
                TabCurve(
                    tabPoint: getCurvePoint() - 15
                )
            )
        )
        .overlay(
            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint() - 20)
            , alignment: .bottomLeading
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
    // extracting point...
    
    func getCurvePoint() -> CGFloat {
        
        // if tabPoint is empty...
        if tabPoints.isEmpty {
            return 10
        } else {
            switch selectedTab {
            case .house:
                return tabPoints[0]
            case .bookmark:
                return tabPoints[1]
            case .message:
                return tabPoints[2]
            case .person:
                return tabPoints[3]
            }
        }
    }
}

struct CustTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
