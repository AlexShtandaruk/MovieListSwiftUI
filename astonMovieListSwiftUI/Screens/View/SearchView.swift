import SwiftUI

struct SearchView: View {
    
    var animation: Namespace.ID
    
    //shared data
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    //activating text field with the help of focus state
    @FocusState var startTF: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            
            //search bar
            HStack(spacing: 20) {
                //close button
                Button {
                    withAnimation {
                        viewModel.searchActivated = false
                    }
                    viewModel.searchText = ""
                    //resetting
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.7))
                    
                }
                
                //search bar
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    //since we need a separate view for search bar
                    TextField("Search", text: $viewModel.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .autocorrectionDisabled(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(.indigo, lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)

            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom, 10)
            
            //show progress if searching else showing not results found if empty
            if let subs = viewModel.searchedSubs {
                
                //no result found
                if subs.isEmpty {
                    VStack(spacing: 10) {
                        Image("notFound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                        Text("Subscribtion not found")
                            .font(.custom(customFont, size: 22).bold())
                        Text("Try more generic search term or try looking for alternative subscribtion.")
                            .font(.custom(customFont, size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .padding()
                }
                //filter result
                else {
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 0) {
                            
                            //found text
                            Text("Found \(subs.count) results")
                                .font(.custom(customFont, size: 24).bold())
                                .padding(.vertical)
                            
                            //staggered grid
                            StaggeredGrid(columns: 2, spacing: 20, list: subs) { sub in
                                
                                //card view
                                subscribtionCardView(sub: sub)
                            }
                        }
                        .padding()
                    }
                }
            } else {
                Loader()
                    .padding(.top, 30)
                    .opacity(viewModel.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("BGColor").ignoresSafeArea()
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
                
            }
        }
    }
    
    @ViewBuilder
    func subscribtionCardView(sub: Subscribtion) -> some View {
        VStack(spacing: 10) {
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
                        .matchedGeometryEffect(id: "\(sub.id)SEARCH", in: animation)
                }
            }
            
            //moving image to top to look like its fixed at half top
                .offset(y: -50)
                .padding(.bottom, -50)
            
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
                //sub.subtitle.contains("180") ? 1 : 1
                    .cornerRadius(25)
        )
        .padding(.top, 50)
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.fromSearchPage = true
                sharedData.detailSubscribtion = sub
                sharedData.showDetailSubscribtion = true
            }
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
