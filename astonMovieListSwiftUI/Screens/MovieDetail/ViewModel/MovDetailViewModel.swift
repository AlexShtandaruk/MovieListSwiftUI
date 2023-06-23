import Foundation

final class MovDetailViewModel: ObservableObject {
    
    @Published var offset: CGFloat = 0
    @Published var selectedTab: String = Genre.drama.rawValue
    
    @Published var hasError: Bool? = false
    @Published var data: [Movie]?
    
    @Published var filter: String = Genre.action.rawValue
    @Published var error: BackendError?
    
    @Injected var fetch: FetchService?
    
    var filtredData: [Movie] {
        switch filter {
        default:
            return data?.filter { $0.genre?.contains(filter) == true } ?? []
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
