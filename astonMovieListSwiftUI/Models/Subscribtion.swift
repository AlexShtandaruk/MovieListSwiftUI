import Foundation

//Subscribtion types
enum SubscribtionTypes: String, CaseIterable {
    case family = "Family"
    case personal = "Personal"
    case corporate = "Сorporate"
    case transgender = "For transgender"
}

struct Subscribtion: Identifiable, Hashable {
    var id = UUID().uuidString
    let type: SubscribtionTypes
    let title: String
    let subtitle: String
    let image: String
    let price: String
    var quantity: Int = 1
}
