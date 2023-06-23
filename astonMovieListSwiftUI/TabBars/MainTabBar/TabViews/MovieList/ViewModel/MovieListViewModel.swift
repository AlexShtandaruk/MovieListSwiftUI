import Foundation

 final class MovieListViewModel: ObservableObject {

    @Published var hasError: Bool? = false
    @Published var data: [Movie]?
    @Published var filter: String = ""
    @Published var error: BackendError?
    
    @Injected var fetch: FetchService?
    
    var filtredData: [Movie] {
            if filter == "" {
                return data ?? []
            } else {
                return data?.filter { $0.title?.contains(filter) ?? Bool() } ?? []
            }
        }

    init() {
        
        fetch?.fetchData(completion: { [weak self] in
            
            guard let self = self else { return }
            
            self.hasError = self.fetch?.hasError
            self.error = self.fetch?.error
            self.data = self.fetch?.data
        })
    }
}
 

//fileprivate enum MovieList: String, CaseIterable {
//
//    case movieOne = "tt3896198"
//    case movieTwo = "tt0120737"
//    case movieThree = "tt0265086"
//    case movieFour = "tt0093058"
//    case movieFive = "tt0111161"
//    case movieSix = "tt0068646"
//    case movieSeven = "tt0108052"
//    case movieEight = "tt0109830"
//    case movieNine = "tt1375666"
//    case movieTen = "tt0133093"
//    case movieElewen = "tt0120815"
//    case movieTwelve = "tt0110357"
//}
//
//
//
//final class MovieListViewModel: ObservableObject {
//
//    @Published var hasError = false
//    @Published var data: [Movie]?
//    @Published var filter: String = ""
//    @Published var error: BackendError?
//
//    @Injected var network: Networking?
//    @Injected var storage: DataCaretaker?
//
//    var filtredData: [Movie] {
//            if filter == "" {
//                return data ?? []
//            } else {
//                return data?.filter { $0.title?.contains(filter) ?? Bool() } ?? []
//            }
//        }
//
//    init() {
//        getData()
//    }
//
//    func getData() {
//
//        let group = DispatchGroup()
//        let queue = OperationQueue()
//        queue.maxConcurrentOperationCount = 1
//        var data: [Movie] = []
//
//        for film in MovieList.allCases {
//            group.enter()
//            network?.getMovieData(film: film.rawValue) { [weak self] result in
//
//                guard let self = self else { return }
//
//                switch result {
//                case .success(let model):
//                    if let model = model {
//                        queue.addOperation {
//                            data.append(model)
//                        }
//                    }
//                case .failure(let error):
//                    self.hasError = true
//                    self.error = error
//                    self.data = self.storage?.loadMovieList()
//                }
//                group.leave()
//            }
//        }
//        group.notify(queue: .main) {
//            if data.isEmpty == false {
//                self.data = data
//                self.storage?.saveMovieList(data)
//            }
//        }
//    }
//}

    //func tapOnData(data: Movie?) {}
//}

/*
protocol MovieListViewModelProtocol: ObservableObject {

    var data: [Movie]? { get set }
    var error: BackendError? { get set }
    var hasError: Bool { get set }
    var network: Networking? { get set }
    var storage: DataCaretaker? { get set }

    func getData()
    func tapOnData(data: Movie?)
}
*/
