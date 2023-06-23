import SwiftUI

struct MainSideTabView: View {
    
    //selected tab
    @State var selectedTab: String = "Home"
    @State var showMenu: Bool = false
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    var animation: Namespace.ID
    
    var body: some View {
        
        ZStack {
            Color(uiColor: .systemIndigo)
                .ignoresSafeArea()
            
            // side menu
            SideMenuView(selectedTab: $selectedTab)
            
           
                ZStack {
                    
                    //two background cards
                    Color.white
                        .opacity(0.5)
                        .cornerRadius(showMenu ? 15 : 0)
                    //shadow
                        .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                        .offset(x: showMenu ? -25 : 0)
                        .padding(.vertical, 30)
                    
                    Color.white
                        .opacity(0.4)
                        .cornerRadius(showMenu ? 15 : 0)
                    //shadow
                        .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                        .offset(x: showMenu ? -50 : 0)
                        .padding(.vertical, 60)
                    
                    SideTabView(selectedTab: $selectedTab, animation: animation)
                        .environmentObject(sharedData)
                        .cornerRadius(showMenu ? 15 : 0)
                    
                }
                //scaling and moving the view
                .scaleEffect(showMenu ? 0.85 : 1)
                .offset(x: showMenu ? getRect().width - 120 : 0)
                .disabled(showMenu ? true : false)
                .ignoresSafeArea()
                .toolbar(.hidden, for: .tabBar)
            
            //if showTabBar == true {}
                .overlay(
                    //menu button
                    Button(action: {
                        withAnimation(.spring()) {
                            showMenu.toggle()
                        }
                    }, label: {
                        //animatedd drawer button
                        VStack(spacing: 5) {
                            Capsule()
                                .fill(showMenu ? Color.white : Color.primary)
                                .frame(width: 30, height: 3)
                                .rotationEffect(.init(degrees: showMenu ? -45 : 0))
                                .offset(x: showMenu ? 2 : 0, y: showMenu ? 9 : 0)
                            VStack(spacing: 5) {
                                Capsule()
                                    .fill(showMenu ? Color.white : Color.primary)
                                    .frame(width: 30, height: 3)
                                //moving up when clicked
                                Capsule()
                                    .fill(showMenu ? Color.white : Color.primary)
                                    .frame(width: 30, height: 3)
                                    .offset(y: showMenu ? -8 : 0)
                            }
                            .rotationEffect(.init(degrees: showMenu ? 45 : 0))
                        }
                    })
                    .padding()
                    ,alignment: .topLeading
                )
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
