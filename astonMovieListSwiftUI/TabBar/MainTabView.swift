import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack {
                TabView(selection: $router.tabSelection) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        NavigationContainerView(
                            transition: Transition.custom(.slide)) {
                                AssemblyBuiler.createLogInView()
                            }
                            .tag(tab)
                    }
                }
            }
            // custom tab bar...
            CustTabBar(selectedTab: $router.tabSelection)
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
