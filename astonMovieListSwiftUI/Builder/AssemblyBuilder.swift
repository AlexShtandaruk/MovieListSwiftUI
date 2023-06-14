import SwiftUI

class AssemblyBuiler {
    
    static func createMovieListView() -> some View {
        let viewModel = MovieListViewModel()
        let view = MovieListScreen(viewModel: viewModel)
        return view
    }
    
    static func createMovieDetailView(data: Movie) -> some View {
        let viewModel = MovieDetailViewModel(data: data)
        let view = MovieDetailScreen(viewModel: viewModel)
        return view
    }
    
    // auth
    
    static func createLogInView() -> some View {
        let viewModel = AccountViewModel()
        let view = AccountScreen(viewModel: viewModel)
        return view
    }
}
