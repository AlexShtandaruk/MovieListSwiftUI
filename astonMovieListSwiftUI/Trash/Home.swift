//import SwiftUI
//
//struct Home: View {
//    
//    @EnvironmentObject var router: Router
//    
//    init() { UITabBar.appearance().isHidden = true }
//    
//    var body: some View {
//        
//        ZStack(alignment: .bottom) {
//            VStack {
//                TabView(selection: $router.tabSelection) {
//                    NavigationContainerView(
//                        transition: Transition.custom(.slide)) {
//                            AssemblyBuiler.createMovieListView()
//                        }
//                        .tag(0)
//                    NavigationContainerView(
//                        transition: Transition.custom(.slide)) {
//                            AssemblyBuiler.createLogInView()
//                        }
//                        .tag(1)
//                    NavigationContainerView(
//                        transition: Transition.custom(.slide)) {
//                            AssemblyBuiler.createLogInView()
//                        }
//                        .tag(1)
//                    NavigationContainerView(
//                        transition: Transition.custom(.slide)) {
//                            AssemblyBuiler.createMovieListView()
//                        }
//                        .tag(0)
//                }
//            }
//            Color(.black)
//                .ignoresSafeArea()
//            
//            // custom tab bar...
//            CustomTabBar(selectedTab: $router.tabSelection)
//        }
//    }
//}
//
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
