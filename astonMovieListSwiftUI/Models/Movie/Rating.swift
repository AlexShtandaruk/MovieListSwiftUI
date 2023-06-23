import Foundation

// MARK: - Rating model

struct Rating: Codable {
    
    let source: String?
    let value: String?

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
