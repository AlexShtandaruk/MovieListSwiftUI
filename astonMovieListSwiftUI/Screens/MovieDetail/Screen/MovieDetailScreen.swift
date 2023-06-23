import SwiftUI

struct MovieDetailScreen: View {
    
    @StateObject var viewModel: MovDetailViewModel = .init()
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    //for matched geometry effect
    var animation: Namespace.ID
    
    //for dark mode adoption
    //@Environment(\.colorScheme) var scheme
    
    var currentMovie: Movie
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders]) {
                
                //parallax image
                GeometryReader { reader -> AnyView in
                    
                    let offset = reader.frame(in: .global).minY
                    
                    if -offset >= 0 {
                        DispatchQueue.main.async {
                            self.viewModel.offset = -offset
                        }
                    }
                    
                    return AnyView(
                        
                        AsyncImage(
                            url: URL(string: currentMovie.poster ?? String()),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: UIScreen.main.bounds.width,
                                        height: 500 + (offset > 0 ? offset : 0))
                                    .offset(y: (offset > 0 ? -offset : 0))
                                    .overlay(
                                        HStack {
                                            //back button
                                            Button {
                                                sharedData.showDetailMovie = false
                                            } label: {
                                                Image(systemName: "arrow.left")
                                                    .font(.system(size: 20, weight: .bold))
                                                    .foregroundColor(.white)
                                                    .padding(8)
                                                    .background(Color.indigo)
                                                    .clipShape(Circle())
                                            }
                                            Spacer()
                                            
                                            //star button
                                            Button {
                                                
                                            } label: {
                                                Image(systemName: "star.fill")
                                                    .font(.system(size: 20, weight: .bold))
                                                    .padding(8)
                                                    .foregroundColor(.white)
                                                    .background(Color.indigo)
                                                    .clipShape(Circle())
                                            }
                                        }
                                            .padding()
                                        , alignment: .top
                                    )
                            },
                            placeholder: {
                                Loader()
                                    .frame(
                                        width: UIScreen.main.bounds.width,
                                        height: 500 + (offset > 0 ? offset : 0))
                            }
                        )
                    )
                }
                .frame(height: 500)
                
                //cards
                Section {
                    ForEach(Genre.allCases, id: \.self) { genre in
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text(genre.rawValue)
                                .font(.custom(customFont, size: 26).bold())
                                .foregroundColor(.primary)
                                .padding(.leading)
                            
                            VStack(alignment: .leading, spacing: 15) {
                                
                                ForEach(viewModel.filtredData) { movie in
                                    movieDetailCell(movie: movie)
                                        
                                }
                            }
                            
                            Divider()
                                .padding(.top)
                                
                        }
                        .tag(genre.rawValue)
                        .overlay(
                            GeometryReader { reader -> Text in
                                
                                //calculating which tab
                                let offset = reader.frame(in: .global).minY
                                
                                //top area plus header size
                                let height = UIApplication.shared.windows.first!.safeAreaInsets.top + 250
                                
                                if offset < height && offset > 50 && viewModel.selectedTab != genre.rawValue {
                                    DispatchQueue.main.async {
                                        viewModel.selectedTab = genre.rawValue
                                    }
                                }
                                return Text("")
                            }
                        )
                    }
                   
                    
                } header: {
                    MovieDetailHeaderView(movie: currentMovie)
                }
                
            }
        }
        .background(Color("BGColor"))
        
        //only safeArea
        .overlay(
            Color("BGColor")
                .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                .ignoresSafeArea(.all, edges: .top)
                .opacity(viewModel.offset > 500 ? 1 : 0)
            , alignment: .top
        )
        
        //use this enviromentObject for accessing all sub object
        .environmentObject(viewModel)
        .toolbar(.hidden, for: .tabBar)
    }
    
    @ViewBuilder
    func movieDetailCell(movie: Movie) -> some View {
        HStack {
            
            // text
            VStack(alignment: .leading, spacing: 10) {
                
                //title
                Text(movie.title ?? String())
                    .font(.custom(customFont, size: 24).bold())
                    .lineLimit(2)
                    .frame(height: 60)
                    .foregroundColor(.indigo)
                //description
                Text(movie.plot ?? String())
                    .font(.custom(customFont, size: 12))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .lineLimit(5)
                    .frame(height: 80)
                // year and duration
                HStack(spacing: 10) {
                    //year
                    Image(systemName: "calendar")
                        .font(.title2)
                        .foregroundColor(.indigo)
                    Text(movie.year ?? String())
                        .font(.custom(customFont, size: 17).bold())
                    
                    //duration
                    Image(systemName: "timer")
                        .font(.title2)
                        .foregroundColor(.indigo)
                    Text(movie.runtime ?? String())
                        .font(.custom(customFont, size: 17).bold())
                }
            }
            
            Spacer(minLength: 10)
            
            //image
            AsyncImage(url: URL(string: movie.poster ?? String())) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 200)
                    .cornerRadius(30)
            } placeholder: {
                Loader()
                    .frame(width: 150, height: 200)
            }
        }
        .padding()
    }
}


struct MovieDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
