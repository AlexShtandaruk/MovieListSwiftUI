//import SwiftUI
//
//struct MainTabView: View {
//    
//    @EnvironmentObject var router: Router
//    
//    var body: some View {
//        TabView(selection: $router.tabSelection) {
//            
//            NavigationContainerView(
//                transition: Transition.custom(.slide)) {
//                    AssemblyBuiler.createMovieListView()
//                }
//                .tabItem {
//                    Image(systemName: "list.star")
//                        .foregroundColor(.black)
//                }
//                .tag(0)
//            
//            NavigationContainerView(
//                transition: Transition.custom(.slide)) {
//                    AssemblyBuiler.createLogInView()
//                }
//                .tabItem { Image(systemName: "person.fill") }
//                .tag(1)
//        }
//        .accentColor(.red)
//        .onAppear {
//            let itemAppearance = UITabBarItemAppearance()
//            itemAppearance.normal.iconColor = UIColor.white
//            let appeareance = UITabBarAppearance()
//            appeareance.shadowColor = .red
//            appeareance.backgroundColor = .black
//            appeareance.stackedLayoutAppearance = itemAppearance
//            appeareance.inlineLayoutAppearance = itemAppearance
//            appeareance.compactInlineLayoutAppearance = itemAppearance
//            UITabBar.appearance().standardAppearance = appeareance
//        }
//    }
//}
