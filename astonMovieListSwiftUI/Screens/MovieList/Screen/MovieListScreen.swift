import SwiftUI

struct MovieListScreen: View {
    
    @ObservedObject var viewModel: MovieListViewModel
    @EnvironmentObject var routerModel: NavigationContainerViewModel
    
    @State var searchText = ""
    
    init(viewModel: MovieListViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                searchTextField
                    .background(.black)
                    .frame(height: 35)
                list
                    .navigationTitle(Constant.title.localized())
                    .background(Color.black)
                    .scrollContentBackground(.hidden)
                    .navigationBarColor(backgroundColor: .black, titleColor: .white)
                    .toolbar(.visible, for: .tabBar)
                    .alert(isPresented: $viewModel.hasError, content: {
                        Alert(
                            title: Text(Constant.Alert.title.localized()),
                            message: Text(
                                Constant.Alert.failure.localized()+(viewModel.error?.description ?? "")
                            ),
                            dismissButton: .cancel(Text(Constant.Alert.cancel.localized()))
                        )
                    })
            }
            .background(.black)
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    var list: some View {
        List {
            ForEach(viewModel.filtredData) { movie in
                HStack {
                    AsyncImage(url: URL(string: movie.poster ?? "")) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 200, alignment: .center)
                            .cornerRadius(15)
                    } placeholder: { Loader() }
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(movie.title ?? "Default title")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .lineLimit(4)
                            .foregroundColor(.white)
                        Spacer()
                        Text(Constant.duration.localized())
                            .font(.headline)
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                        + Text(movie.runtime ?? "Default duration")
                            .font(.caption)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        Text(Constant.year.localized())
                            .font(.headline)
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                        + Text(movie.year ?? "Default year")
                            .font(.caption)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(height: 200)
                }
                .onTapGesture {
                    routerModel.push(screenView: AssemblyBuiler.createMovieDetailView(data: movie).toAnyView())
                }
            }
            .listRowBackground(Color.black)
        }
    }
    
    var searchTextField: some View {
        ZStack {
            if searchText.isEmpty {
                Text(Constant.request.localized())
                    .foregroundColor(.red.opacity(1))
            }
            TextField("", text: $searchText) { _ in
                viewModel.filter = searchText
            } onCommit: {
                print("onCommit")
            }
        }
        .modifierForTextField()
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

