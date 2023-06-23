import SwiftUI

struct CartPage: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    //delete option
    @State var showDelete: Bool = false
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    //button's
                    HStack {
                        Text("Basket")
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
                        .opacity(sharedData.basketSubscribtion.isEmpty ? 0 : 1)
                        
                    }
                    
                    //checking if liked products are empty
                    if sharedData.basketSubscribtion.isEmpty {
                        Group {
                            Image("emptyCart")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding()
                                .padding(.top, 35)
                            
                            Text("No any item added")
                                .font(.custom(customFont, size: 25))
                                .fontWeight(.semibold)
                            
                            Text("Hit the add button on each subscribtion for save it in cart.")
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
                            ForEach($sharedData.basketSubscribtion) { $sub in
                                
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
                                    CartView(sub: $sub)
                                }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            
            //show total and checkout button
            if !sharedData.basketSubscribtion.isEmpty {
                Group {
                    
                    //total text
                    HStack {
                        
                        Text("Total")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(sharedData.getTotalPrice())
                            .font(.custom(customFont, size: 18).bold())
                            .foregroundColor(.indigo)
                    }
                    
                    
                    //checkout button
                    Button {
                        
                    } label: {
                        Text("Checkout")
                            .font(.custom(customFont, size: 18).bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 18)
                            .frame(maxWidth: .infinity)
                            .background(Color.indigo)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal, 25)
            } else {
                
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BGColor").ignoresSafeArea())
        
    }
    
    func deleteProduct(sub: Subscribtion) {
        if let index = sharedData.basketSubscribtion.firstIndex(where: { currentSub in
            return sub.id == currentSub.id
        }) {
            //removing
            let _ = withAnimation {
                sharedData.basketSubscribtion.remove(at: index)
            }
        }
    }
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
            .environmentObject(SharedDataModel())
    }
}

struct CartView: View {
    
    //making product as binding so as to update in real time
    @Binding var sub: Subscribtion
    
    var body: some View {
        
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
                
                //quantity button
                HStack(spacing: 10) {
                    
                    Text("Quantity")
                        .font(.custom(customFont, size: 13))
                        .foregroundColor(.gray)
                    
                    Button {
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.green)
                            .cornerRadius(4)
                    }
                    
                    Text("Quantity")
                        .font(.custom(customFont, size: 14))
                        .foregroundColor(.gray)
                    
                    
                    Button {
                        sub.quantity = (sub.quantity > 0 ? (sub.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.green)
                            .cornerRadius(4)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.cornerRadius(10))
    }
}
