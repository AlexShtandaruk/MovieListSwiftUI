import SwiftUI

struct SideMenuView: View {
    
    //selected tab
    @Binding var selectedTab: String
    //animation namespace
    @Namespace var animation
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            //profile image / ToDo -> change to asyncImage -> got from url
            Image("image1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .cornerRadius(10)
            
            //padding top for top close button
                .padding(.top, 50)
            
            //head text
            VStack(alignment: .leading, spacing: 6) {
                // MARK: - from auth ToDo title name
                Text("Alex Shtandaruk")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Button(action: {}) {
                    Text(Constant.viewProfileButton.localized())
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.7)
                    
                }
            }
            
            //tab buttons
            VStack(alignment: .leading, spacing: 10) {
                SideTabViewCell(
                    image: ProjectConstant.Images.SideTabBar.home,
                    title: ProjectConstant.SideTabBar.home,
                    selectedTab: $selectedTab,
                    animation: animation
                )
                SideTabViewCell(
                    image: ProjectConstant.Images.SideTabBar.history,
                    title: ProjectConstant.SideTabBar.history,
                    selectedTab: $selectedTab,
                    animation: animation
                )
                SideTabViewCell(
                    image: ProjectConstant.Images.SideTabBar.notification,
                    title: ProjectConstant.SideTabBar.notification,
                    selectedTab: $selectedTab,
                    animation: animation
                )
                SideTabViewCell(
                    image: ProjectConstant.Images.SideTabBar.settings,
                    title: ProjectConstant.SideTabBar.settings,
                    selectedTab: $selectedTab,
                    animation: animation
                )
                SideTabViewCell(
                    image: ProjectConstant.Images.SideTabBar.help,
                    title: ProjectConstant.SideTabBar.help,
                    selectedTab: $selectedTab,
                    animation: animation
                )
            }
            .padding(.leading, -15)
            .padding(.top, 50)
            
            Spacer()
            
            //sign out button
            VStack(alignment: .leading, spacing: 6) {
                SideTabViewCell(
                    image: ProjectConstant.Images.SideTabBar.logOut,
                    title: ProjectConstant.SideTabBar.logOut,
                    selectedTab: .constant(""),
                    animation: animation
                )
                .padding(.leading, -15)
                Text(Constant.createdBy.localized())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(0.6)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

extension SideMenuView {
    struct Constant {
        static let createdBy = "sideMenuView.createdBy"
        static let viewProfileButton = "sideMenuView.viewProfileButton"
    }
}
