import Foundation
//using combime to monitor search field and if user leaves for 5 second then start searching to avoid memory issue
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var subscribtionType: SubscribtionTypes = .family
    
    @Published var filteredSubs: [Subscribtion] = []
    
    //mockdata for example
    @Published var subscribtions: [Subscribtion] = [
        Subscribtion(type: .family, title: "Family", subtitle: "5 devices, 30 days", image: "subFamily", price: "99$"),
        Subscribtion(type: .personal, title: "Personal", subtitle: "1 device, 30 days", image: "subPersonal", price: "49$"),
        Subscribtion(type: .transgender, title: "Transgender", subtitle: "ha-ha, 30 days", image: "subTrans", price: "80$"),
        Subscribtion(type: .corporate, title: "Corporate", subtitle: "15 devices, 30 days", image: "subCorporate", price: "299$"),
        
        Subscribtion(type: .family, title: "Family", subtitle: "5 devices, 180 days", image: "subFamily", price: "299$"),
        Subscribtion(type: .personal, title: "Personal", subtitle: "1 device, 180 days", image: "subPersonal", price: "149$"),
        Subscribtion(type: .transgender, title: "Transgender", subtitle: "ha-ha, 180 days", image: "subTrans", price: "599$"),
        Subscribtion(type: .corporate, title: "Corporate", subtitle: "15 devices, 180 days", image: "subCorporate", price: "999$"),
    ]
    
    //more subs on the type
    @Published var showMoreSubsOnType: Bool = false
    
    //search data
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedSubs: [Subscribtion]?
    
    var searchCancellable: AnyCancellable?
    
    init() {
        filterSubsByType()
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterSubsBySearch()
                } else {
                    self.searchedSubs = nil
                }
            })
    }
    
    func filterSubsByType() {
        
        //filtering subs by subscribtion type
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.subscribtions
            
            //since it will require more memory so were using lazy to perform more
                .lazy
                .filter { sub in
                    return sub.type == self.subscribtionType
                }
            
            //limiting result
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredSubs = result.compactMap({ sub in
                    return sub
                })
            }
        }
    }
    
    func filterSubsBySearch() {
        
        //filtering subs by subscribtion type
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.subscribtions
            
            //since it will require more memory so were using lazy to perform more
                .lazy
                .filter { sub in
                    return sub.title.lowercased().contains(self.searchText.lowercased())
                }
            
            //limiting result
                .prefix(4)
            DispatchQueue.main.async {
                self.searchedSubs = result.compactMap({ sub in
                    return sub
                })
            }
        }
    }
}
