import SwiftUI

struct LikedPage: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    //delete option
    @State var showDelete: Bool = false
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                
                //button's
                HStack {
                    Text("Favourite")
                        .font(.custom(customFont, size: 28)
                            .bold())
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showDelete.toggle()
                        }
                    } label: {
                        Image(systemName: "trash.fill")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    .opacity(sharedData.likedSubscribtion.isEmpty ? 0 : 1)
                    
                }
                
                //checking if liked products are empty
                if sharedData.likedSubscribtion.isEmpty {
                    Group {
                        Image("emptyFavourite")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding()
                            .padding(.top, 35)
                        
                        Text("No favourites yet")
                            .font(.custom(customFont, size: 25))
                            .fontWeight(.semibold)
                        
                        Text("Hit the like button on each subscribtion to save favourite ones.")
                            .font(.custom(customFont, size: 18))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.top, 10)
                    }
                } else {
                    
                    //displaying products
                    VStack(spacing: 15) {
                        
                        //for designing
                        ForEach(sharedData.likedSubscribtion) { sub in
                            
                            HStack(spacing: 0) {
                                if showDelete {
                                    Button {
                                        deleteProduct(sub: sub)
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.red)
                                    }
                                    .padding(.trailing)
                                    
                                }
                                cardView(sub: sub)
                            }
                        }
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        //.toolbar(.hidden, for: .navigationBar)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BGColor").ignoresSafeArea())
        .toolbar(.hidden, for: .tabBar)
    }
    
    @ViewBuilder
    func cardView(sub: Subscribtion) -> some View {
        
        //content
        HStack(spacing: 15) {
            //image
            Image(sub.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 90)
                .padding()
            
            //text
            VStack(alignment: .leading, spacing: 8) {
                Text(sub.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                
                Text(sub.subtitle)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(.indigo)
                
                Text("Type: \(sub.type.rawValue)")
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.cornerRadius(10))
    }
    
    func deleteProduct(sub: Subscribtion) {
        if let index = sharedData.likedSubscribtion.firstIndex(where: { currentSub in
            return sub.id == currentSub.id
        }) {
            //removing
            let _ = withAnimation {
                sharedData.likedSubscribtion.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
