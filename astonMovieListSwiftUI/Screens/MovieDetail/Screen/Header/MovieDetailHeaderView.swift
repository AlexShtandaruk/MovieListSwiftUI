import SwiftUI

struct MovieDetailHeaderView: View {
    
    var movie: Movie
    
    @EnvironmentObject var viewModel: MovDetailViewModel
    
    //for dark mode adoption
    @Environment(\.colorScheme) var scheme
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 0) {
                //backButton
                Button {
                    sharedData.showDetailMovie = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: getSize(), height: getSize())
                        .foregroundColor(.primary)
                        .opacity(getSize() > 30 ? 1 : 0)
                }
                
                //title
                Text("Movie")
                    .font(.custom(customFont, size: 28).bold())
                    .foregroundColor(.indigo)
                +
                Text(" detail")
                    .font(.custom(customFont, size: 28).bold())
                    .foregroundColor(.gray)
                
            }
            
            VStack(alignment: .leading, spacing: 10) {
                
                HStack(spacing: 20) {
                    //duration
                    HStack(spacing: 10) {
                        Image(systemName: "timer")
                            .font(.caption)
                        Text(movie.runtime ?? String())
                            .font(.custom(customFont, size: 13))
                    }
                    //rating
                    HStack(spacing: 10) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                        Text(movie.ratings?[0].value ?? String())
                            .font(.custom(customFont, size: 13))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                //description
                Text("Description: \(movie.plot ?? String())")
                    .font(.custom(customFont, size: 12))
                    .foregroundColor(.gray)
                    .lineLimit(4)
                
                ZStack {
                    
                    // watch button
                    Button(action: {
                        //
                    }, label: {
                        Text("Start watching")
                            .font(.custom(customFont, size: 15).bold())
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.indigo.cornerRadius(20))
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                    })
                    .opacity(viewModel.offset > 500 ? 1 - Double((viewModel.offset - 500) / 50) : 1)
                    
                    //for automatic scrolling
                    ScrollViewReader { reader in
                        
                        //custom scroll view
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                
                                ForEach(Genre.allCases, id: \.self) { genre in
                                    
                                    Text(genre.rawValue)
                                        .font(.custom(customFont, size: 15).bold())
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                        .background(
                                            Color.indigo
                                                .opacity(viewModel.selectedTab == genre.rawValue ? 1 : 0)
                                        )
                                        .clipShape(Capsule())
                                        .foregroundColor(.primary)
                                        .id(genre.rawValue)
                                }
                                .onChange(of: viewModel.selectedTab, perform: { value in
                                    withAnimation(.easeInOut) {
                                        reader.scrollTo(viewModel.selectedTab, anchor: .leading)
                                    }
                                    
                                })
                            }
                        }
                        
                        //visible only when scrolls up
                        .opacity(viewModel.offset > 500 ? Double((viewModel.offset - 500) / 50) : 0)
                    }
                    
                }
            }
            
            //default frame = 250 - 50 = 200
            .frame(height: 200)
            
            if viewModel.offset > 500 {
                Divider()
                
            }
        }
        .padding(.horizontal)
        .frame(height: 250)
        .background(Color("BGColor"))
    }
    
    //getting size of button and doing animation
    func getSize() -> CGFloat {
        if viewModel.offset > 500 {
            let progress = (viewModel.offset - 500) / 50
            
            if progress <= 1.0 {
                return progress * 50
            } else {
                return 50
            }
        }
        else {
            return 0
        }
    }
}


struct MovieDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
