import SwiftUI

struct ProfilePage: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("My profile")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15) {
                        Image("profileImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        Text("Alex Shtandaruk")
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                           Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Adress: 43 Lenin square,\nMoscow, RU")
                                .font(.custom(customFont, size: 15))
                                .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        Color.white
                            .cornerRadius(15)
                    )
                    .padding()
                    .padding(.top, 40)
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
                
                //custom navigationlinks
                customNavigationLink(title: "Edit profile") {
                    Text("")
                        .navigationTitle("Edit profile")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(   Color("BGColor").ignoresSafeArea())
                }
                
                customNavigationLink(title: "Notifications") {
                    Text("")
                        .navigationTitle("Notifications")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(   Color("BGColor").ignoresSafeArea())
                }
                
                customNavigationLink(title: "Watching history") {
                    Text("")
                        .navigationTitle("Watching history")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(   Color("BGColor").ignoresSafeArea())
                }
                
                customNavigationLink(title: "Payment") {
                    Text("")
                        .navigationTitle("Payment")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(   Color("BGColor").ignoresSafeArea())
                }
                
                customNavigationLink(title: "Settings") {
                    Text("")
                        .navigationTitle("Settings")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(   Color("BGColor").ignoresSafeArea())
                }
                
            }
            .toolbar(.hidden, for: .navigationBar)
            //MARK: - ToDo  hide tabBar
            .toolbar(.hidden, for: .tabBar)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BGColor").ignoresSafeArea())
        }
        
    }
    
    //avoiding view structs
    @ViewBuilder
    func customNavigationLink<Detail: View>(
        title: String,
        @ViewBuilder content: @escaping () -> Detail
    ) -> some View {
        
        NavigationLink {
            content()
        } label: {
            Text(title)
                .font(.custom(customFont, size: 17))
                .fontWeight(.semibold)
            
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundColor(.black)
        .padding()
        .background(
            Color.white
                .cornerRadius(12)
        )
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
