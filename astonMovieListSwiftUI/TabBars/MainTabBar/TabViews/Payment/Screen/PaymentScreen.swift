import SwiftUI

struct PaymentScreen: View {
    
    @StateObject var viewModel: HomeViewModel = .init()
    var animation: Namespace.ID
    
    //sharedData
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            //search bar
            VStack(spacing: 15) {
                
                ZStack {
                    if viewModel.searchActivated {
                        searchBar()
                    } else {
                        searchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.3)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        viewModel.searchActivated = true
                    }
                }
                
                Text("subscription\ntoday")
                    .font(.custom(customFont, size: 45))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                //product tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(SubscribtionTypes.allCases, id: \.self) { type in
                            
                            //Subscribtion Type view
                            subscribtionTypeView(type: type)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 28)
                
                //subscribtion page
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(viewModel.filteredSubs) { sub in
                            
                            //sub card view
                            subscribtionCardView(sub: sub)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                .padding(.top, 30)
                
                //see more button, this button will show all products on the current product type
                //since here showing only 4
                Button(action: { viewModel.showMoreSubsOnType = true }) {
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("see more")
                    }
                    .font(.custom(customFont, size: 15).bold())
                    .foregroundColor(.indigo)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 10)
            }
            .padding(.vertical)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BGColor"))
        .toolbar(.hidden, for: .tabBar)
        
        //updating data whenever tab changes
        .onChange(of: viewModel.subscribtionType) { newValue in
            viewModel.filterSubsByType()
        }
        
        //preview issue
        .sheet(isPresented: $viewModel.showMoreSubsOnType) {
            MoreSubsView()
        }
        
        //dispaying search view
        .overlay(
            ZStack {
                if viewModel.searchActivated {
                    SearchView(animation: animation)
                        .environmentObject(viewModel)
                }
            }
        )
    }
    
    //since we are adding geometry effect
    //avoiding code replication
    @ViewBuilder
    func searchBar() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            
            //since we need a separate view for search bar
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            Capsule()
                .strokeBorder(Color.gray, lineWidth: 0.8)
        )
    }
    
    @ViewBuilder
    func subscribtionCardView(sub: Subscribtion) -> some View {
        VStack(spacing: 10) {
            
            //adding matched geomentry effect
            ZStack {
                if sharedData.showDetailSubscribtion {
                    Image(sub.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else {
                    Image(sub.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(sub.id)IMAGE", in: animation)
                }
            }
            .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
            //moving image to top to look like its fixed at half top
            .offset(y: -80)
            .padding(.bottom, -80)
            
            Text(sub.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            Text(sub.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            Text(sub.price)
                .font(.custom(customFont, size: 16))
                .fontWeight(.bold)
                .foregroundColor(.indigo)
                .padding(.top, 5)
            
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        //showing subscribtion detail when tapped
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.detailSubscribtion = sub
                sharedData.showDetailSubscribtion = true
            }
        }
    }
    
    @ViewBuilder
    func subscribtionTypeView(type: SubscribtionTypes) -> some View {
        Button {
            withAnimation {
                viewModel.subscribtionType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
            
            //changing color based on current subscribtion type
                .foregroundColor(viewModel.subscribtionType == type ? .indigo : .gray)
                .padding(.bottom, 10)
            
            //adding indicatior at bottom
                .overlay(
                    
                    //adding matched geometry effect
                    ZStack{
                        if viewModel.subscribtionType == type {
                            Capsule()
                                .fill(.indigo)
                                .matchedGeometryEffect(id: "SUBSCRIBTIONTAB", in: animation)
                                .frame(height: 2)
                        } else {
                            Capsule()
                                .fill(.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    ,alignment: .bottom
                )
        }
        
    }
}

struct PaymentScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
