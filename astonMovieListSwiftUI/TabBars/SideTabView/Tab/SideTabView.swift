import SwiftUI

struct SideTabView: View {
    
    @Binding var selectedTab: String
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    //animation namespace
    var animation: Namespace.ID
    
    var body: some View {
        
        //tab view with tabs
        TabView(selection: $selectedTab) {
            //views
            
            MovieListScreen(animation: animation)
                .environmentObject(sharedData)
                .tag(ProjectConstant.SideTabBar.home)
            
            NotificationView()
                .tag(ProjectConstant.SideTabBar.notification)
            
            SettingsView()
                .tag(ProjectConstant.SideTabBar.settings)
            
            HistortyView()
                .tag(ProjectConstant.SideTabBar.history)
            
            HelpView()
                .tag(ProjectConstant.SideTabBar.help)
        }
        //hidding tab bar
        .toolbar(.hidden, for: .tabBar)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
    MainPage()
    }
}

// all subview

struct HistortyView: View{
    
    var body: some View {
        NavigationView {
            Text("History")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .navigationTitle("History")
                .toolbar(.hidden, for: .tabBar)
        }
    }
}

struct NotificationView: View{
    
    var body: some View {
        NavigationView {
            Text("Notification")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .navigationTitle("Notification")
                .toolbar(.hidden, for: .tabBar)
        }
    }
}

struct SettingsView: View{
    
    var body: some View {
        NavigationView {
            Text("Settings")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .navigationTitle("Settings")
                .toolbar(.hidden, for: .tabBar)
        }
    }
}

struct HelpView: View{
    
    var body: some View {
        NavigationView {
            Text("Help")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .navigationTitle("Help")
                .toolbar(.hidden, for: .tabBar)
        }
    }
}
