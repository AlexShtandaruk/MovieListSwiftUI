import SwiftUI

struct MovieListScreen: View {
    
    @ObservedObject var viewModel: MovieListViewModel = .init()
    
    var animation: Namespace.ID
    
    //search text
    @State var searchQuery: String = ""
    
    //offset's
    @State var offset: CGFloat = 0
    
    //start offset
    @State var startOffset: CGFloat = 0
    
    //to move title to center were getting the title width
    @State var titleOffset: CGFloat = 0
    
    //to get scrollview padded from the top where going to get height of the title bar
    @State var titleBarHeight: CGFloat = 0
    
    //to adopt for dark mode
    @Environment(\.colorScheme) var scheme
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    //@EnvironmentObject var routerModel: NavigationContainerViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            
            //title
            VStack {
                
                //moving search bar to top if user start typing
                if searchQuery == "" {
                    
                    //icon's navBar
                    HStack {

                        Spacer()
                        Button {} label: {
                            Image(systemName: "star")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding()
                    
                    //title navBar
                    HStack {
                        (
                        Text("Movie")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        +
                        Text(" List")
                            .foregroundColor(.gray)
                        )
                        .font(.largeTitle)
                        .overlay (
                            GeometryReader { reader -> Color in
                                
                                let width = reader.frame(in: .global).maxX
                                
                                DispatchQueue.main.async {
                                    //storing
                                    if titleOffset == 0 {
                                        titleOffset = width
                                    }
                                }
                                return Color.clear
                            }
                                .frame(width: 0, height: 0)
                        )
                        .padding()
                        
                        //getting offset and moving the view
                        .offset(getOffset())
                        //scaling
                        .scaleEffect(getScale())
                        
                        Spacer()
                    }
                }
                
                VStack {
                    
                    //search bar
                    HStack(spacing: 15) {
                        Image(systemName: "a.magnify")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(.gray)
                        TextField("Search movie", text: $searchQuery)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.05))
                    .cornerRadius(8)
                    .padding()
                    
                    if searchQuery == "" {
                        
                        //divider line
                        HStack {
                            Text("LAST MOVIE'S")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.6))
                                .frame(height: 0.5)
                        }
                        .padding()
                    }
                }
                .offset(y: offset > 0 && searchQuery == "" ? (offset <= 95 ? -offset : -95) : 0)
            }
            .zIndex(1)
            //padding bottom to decrease hight of the view
            .padding(.bottom, searchQuery == "" ? getOffset().height : 0)
            .background(
                ZStack {
                    let color = scheme == .dark ? Color.black : Color.white
                    LinearGradient(gradient: .init(colors: [color, color, color, color, color.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                }
                    .ignoresSafeArea()
            )
            .overlay(
                GeometryReader { reader -> Color in
                    
                    let height = reader.frame(in: .global).maxY
                    
                    DispatchQueue.main.async {
                        if titleBarHeight == 0 {
                            titleBarHeight = height - (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
                        }
                    }
                    return Color.clear
                }
            )
            //animating only if user starts typing
            .animation(.easeInOut, value: searchQuery != "")
            
            //scroll view
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(viewModel.filtredData) { movie in
                        // movie card row view
                        movieCell(movie: movie)
                    }
                }
                .padding(.top, 10)
                .padding(.top, searchQuery == "" ? titleBarHeight : 90)
                
                //getting offset by using geomenty reader
                .overlay (
                    GeometryReader { proxy -> Color in
                        
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            // to get original offset ie from 0 just minus start offset
                            if startOffset == 0 {
                                startOffset = minY
                            }
                            offset = startOffset - minY
                        }
                        return Color.clear
                    }
                        .frame(width: 0, height: 0)
                    , alignment: .top
                )
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    func getOffset() -> CGSize {
        var size: CGSize = .zero
        
        let screenWidth = UIScreen.main.bounds.width / 2
        
        //since width is slow moving were multiplying with 1.5
        size.width = offset > 0 ? (offset * 1.5 <= (screenWidth - titleOffset) ? offset * 1.5 : (screenWidth - titleOffset)) : 0
        size.height = offset > 0 ? (offset <= 75 ? -offset : -75) : 0
        return size
    }
    
    //little bit shrinking title when scrolling
    func getScale() -> CGFloat {
        if offset > 0 {
            let screenWidth = UIScreen.main.bounds.width
            let progress = 1 - (getOffset().width / screenWidth)
            return progress >= 0.9 ? progress : 0.9
        } else {
            return 1
        }
    }
    
    @ViewBuilder
    func movieCell(movie: Movie) -> some View {
        HStack(spacing: 15) {
            
            //adding matched geomentry effect
            ZStack {
                if sharedData.showDetailMovie {
                    AsyncImage(
                        url: URL(string: movie.poster ?? String()),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 120, maxHeight: 150)
                                .cornerRadius(30)
                                .opacity(0)
                        },
                        placeholder: {
                            Loader()
                                .frame(maxWidth: 120, maxHeight: 150)
                        }
                    )
                } else {
                    AsyncImage(
                        url: URL(string: movie.poster ?? String()),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 120, maxHeight: 150)
                                .cornerRadius(30)
                                .matchedGeometryEffect(id: "\(movie.id)IMAGE", in: animation)
                        },
                        placeholder: {
                            Loader()
                                .frame(maxWidth: 120, maxHeight: 150)
                        }
                    )
                }
            }
            
            // text
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title ?? String())
                    .fontWeight(.bold)
                
                // duration
                Text("Duration: ")
                    .font(.caption)
                    .foregroundColor(.indigo)
                +
                Text(movie.runtime ?? String())
                    .font(.caption)
                    .foregroundColor(.gray)
                
                // year
                Text("Year: ")
                    .font(.caption)
                    .foregroundColor(.indigo)
                +
                Text(movie.year ?? String())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .onTapGesture {
            //showing subscribtion detail when tapped
            withAnimation(.easeInOut) {
                sharedData.detailMovie = movie
                sharedData.showDetailMovie = true
            }
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// MARK: - Constant's

extension MovieListScreen {
    
    struct Constant {
        static let title = "movieListScreen.title"
        static let duration = "movieListScreen.duration"
        static let year = "movieListScreen.year"
        static let request = "movieListScreen.request"
        
        
        struct Alert {
            static var failure = "movieListScreen.alert.failure"
            static var statusCode = "movieListScreen.alert.statusCode"
            static var cancel = "movieListScreen.alert.cancel"
            static var title = "movieListScreen.alert.title"
        }
    }
}

struct Loader: View {
    
    @State var animate = false
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(
                    AngularGradient(gradient: .init(colors: [.orange, .red]), center: .center),
                    style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .frame(width: 20, height: 20, alignment: .center)
                .rotationEffect(.init(degrees: self.animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false),
                           value: UUID())
        }
        .frame(width: 100, height: 80)
        .onAppear {
            self.animate.toggle()
        }
    }
}


