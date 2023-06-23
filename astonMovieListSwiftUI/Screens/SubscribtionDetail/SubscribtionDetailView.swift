import SwiftUI

struct SubscribtionDetailView: View {
    
    var subscribtion: Subscribtion
    
    //for matched geometry effect
    var animation: Namespace.ID
    
    //shared data model
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
       
        VStack {
            
            //title bar and subscribtion image
            VStack {
                
                //title bar
                HStack {
                    
                    //close button
                    Button {
                        //closing view
                        withAnimation(.easeInOut) {
                            sharedData.showDetailSubscribtion = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    Spacer()
                    
                    //like button
                    Button {
                        addToLiked()
                    } label: {
                        Image(systemName: "heart.fill")
                            .font(.title2)
                            .foregroundColor(isLiked() ? Color.red : Color.black.opacity(0.7))
                    }

                }
                .padding()
                
                //subscribtion image
                Image(subscribtion.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //adding matched geometry effect
                    .matchedGeometryEffect(id: "\(subscribtion.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            //subscribtion details
            ScrollView(.vertical, showsIndicators: false) {
                
                //subscribtion data
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(subscribtion.title)
                        .font(.custom(customFont, size: 20).bold())
                    
                    Text(subscribtion.subtitle)
                        .font(.custom(customFont, size: 11))
                        .foregroundColor(.gray)
                    
                    Text("Get 2 free weeks bonus")
                        .font(.custom(customFont, size: 16).bold())
                        .padding(.top)
                    
                    Text("Available when you pay for a subscription for the first time. Does not interact with other promotions, discounts and promo codes. Subgeninities can be clarified in technical support.")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(.gray)
                    
                    // full description button
                    Button {
                        
                    } label: {
                        
                        // since we need image at right
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundColor(.indigo)
                    }
                    
                    //price
                    HStack {
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                        
                            Spacer()
                        Text(subscribtion.price)
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(.indigo)
                    }
                    .padding(.vertical, 20)
                    
                    //add to basket button
                    Button {
                        addToCart()
                    } label: {
                        Text("\(isCart() ? "added" : "add") to cart")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                (isCart() ? Color.gray : Color.indigo)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                            
                    }
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            
            //corner radius only for the top side
            .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
            .ignoresSafeArea()
        }
        .animation(.easeInOut, value: sharedData.likedSubscribtion)
        .animation(.easeInOut, value: sharedData.basketSubscribtion)
        .background(Color("BGColor").ignoresSafeArea())
        .zIndex(0)
        .toolbar(.hidden, for: .tabBar)
    }
    
    func isLiked() -> Bool {
        return sharedData.likedSubscribtion.contains { sub in
            return self.subscribtion.id == sub.id
        }
    }
    
    func isCart() -> Bool {
        return sharedData.basketSubscribtion.contains { sub in
            return self.subscribtion.id == sub.id
        }
    }
    
    func addToLiked() {
        if let index = sharedData.likedSubscribtion.firstIndex(where: { sub in
            return self.subscribtion.id == sub.id
        }) {
            //remove from liked
            sharedData.likedSubscribtion.remove(at: index)
        } else {
            //add to liked
            sharedData.likedSubscribtion.append(subscribtion)
        }
    }
    
    func addToCart() {
        if let index = sharedData.basketSubscribtion.firstIndex(where: { sub in
            return self.subscribtion.id == sub.id
        }) {
            //remove from liked
            sharedData.basketSubscribtion.remove(at: index)
        } else {
            //add to liked
            sharedData.basketSubscribtion.append(subscribtion)
        }
    }
}

struct SubscribtionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
