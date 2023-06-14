import Foundation

// MARK: - Output

protocol MovieDetailPresenterProtocol: ObservableObject, AnyObject {
    
    init(data: Movie)
    
    func getData()
    func tapBack()
    func tapLogOut()
}

class MovieDetailViewModel: MovieDetailPresenterProtocol {
    
    @Published var data: Movie
    
    required init(data: Movie) {
        self.data = data
    }
    
    func getData() {}
    func tapBack() {}
    func tapLogOut() {}
}
