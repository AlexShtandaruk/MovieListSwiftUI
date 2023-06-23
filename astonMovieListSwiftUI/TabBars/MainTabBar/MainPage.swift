import SwiftUI

struct MainPage: View {
    
    //current tab
    @State var currentTab: Tab = .home
    
    @StateObject var sharedData: SharedDataModel = .init()
    
    //animation namespace
    @Namespace var animation
    
    var body: some View {
        
        VStack(spacing: 0) {
            //tab view
            TabView(selection: $currentTab) {
                
                MainSideTabView(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.home)
                    
                PaymentScreen(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.payment)
                
                LikedPage()
                    .environmentObject(sharedData)
                    .tag(Tab.liked)
                
                ProfilePage()
                    .tag(Tab.profilet)
                
                CartPage()
                    .environmentObject(sharedData)
                    .tag(Tab.cart)
            }
            
            //custom tab bar
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button(action: {
                        
                        //updating tab
                        currentTab = tab
                    }) {
                        Image(systemName: tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                        
                        //appling little shadow at background
                            .background(
                                Color.indigo
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                //bluring
                                    .blur(radius: 5)
                                //making little big
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? .indigo : .black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
        .background(Color("BGColor")
            .ignoresSafeArea()
            )
        .overlay(
            ZStack {
                //detail page
                if let subscribtion = sharedData.detailSubscribtion, sharedData.showDetailSubscribtion {
                    SubscribtionDetailView(subscribtion: subscribtion, animation: animation)
                        .environmentObject(sharedData)
                    
                    //adding transition
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
                
                //detail page
                if let movie = sharedData.detailMovie, sharedData.showDetailMovie {
                    MovieDetailScreen(animation: animation, currentMovie: movie)
                        .environmentObject(sharedData)
                    
                    //adding transition
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
        
        .toolbar(.hidden, for: .tabBar)
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// tab cases, #2 make case iterable
enum Tab: String, CaseIterable {
    //raw value must be image name in asset
    case home = "house.fill"
    case payment = "banknote.fill"
    case profilet = "person.fill"
    case liked = "heart.fill"
    case cart = "cart.fill"
}

