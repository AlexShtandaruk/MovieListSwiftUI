import Foundation

final class SharedDataModel: ObservableObject {
 
    //detail subscribtion data
    @Published var detailSubscribtion: Subscribtion?
    @Published var showDetailSubscribtion: Bool = false
    
    //detail movie data
    @Published var detailMovie: Movie?
    @Published var showDetailMovie: Bool = false
    
    //matched geometry effect from search page
    @Published var fromSearchPage: Bool = false
    
    //liked subscribtion
    @Published var likedSubscribtion: [Subscribtion] = []
    
    //basket subscribtion
    @Published var basketSubscribtion: [Subscribtion] = []
    
    //calculating total price
    func getTotalPrice() -> String {
        var total: Int = 0
        
        basketSubscribtion.forEach { sub in
            let price = sub.price.replacingOccurrences(of: "$ ", with: "") as NSString
            let quantity = sub.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        return "\(total)"
    }
}
