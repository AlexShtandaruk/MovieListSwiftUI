import SwiftUI

struct MovieDetailScreen: View {
    
    @StateObject var viewModel: MovieDetailViewModel
    @EnvironmentObject var routerModel: NavigationContainerViewModel
    
    init(viewModel: MovieDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                movieCell
                Spacer()
            }
            .background(.black)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        routerModel.pop()
                    }
                }
            }
        }
    }
    
    var movieCell: some View {
        VStack {
            Text(viewModel.data.title ?? "")
                .fontWeight(.bold)
                .lineLimit(4)
                .font(.system(size: 30))
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
            poster
            info
        }
        
    }
    
    var poster: some View {
        AsyncImage(url: URL(string: viewModel.data.poster ?? "")) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 350, alignment: .center)
                .cornerRadius(20)
        } placeholder: {
            Loader()
        }
    }
    
    var info: some View {
        VStack(alignment: .leading) {
            Text(Constant.plot.localized())
                .font(.headline)
                .font(.system(size: 20))
                .foregroundColor(.red)
            + Text(viewModel.data.plot ?? "")
                .font(.caption)
                .font(.system(size: 15))
                .foregroundColor(.white)
            Text(Constant.duration.localized())
                .font(.headline)
                .font(.system(size: 20))
                .foregroundColor(.red)
            + Text(viewModel.data.runtime ?? "")
                .font(.caption)
                .font(.system(size: 15))
                .foregroundColor(.white)
        }
    }
}

// MARK: - Constant's

extension MovieDetailScreen {
    struct Constant {
        static let duration = "movieDetailScreen.duration"
        static let plot = "movieDetailScreen.plot"
        static let back = "movieDetailScreen.back"
    }
}
