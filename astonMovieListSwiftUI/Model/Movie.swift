import Foundation

// MARK: - Movie model

struct Movie: Identifiable, Codable {
    
    var id: String? { title }
    let title: String?
    let year: String?
    let rated: String?
    let released: String?
    let runtime: String?
    let genre: String?
    let director: String?
    let writer: String?
    let actors: String?
    let plot: String?
    let language: String?
    let country: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]?
    let metascore, imdbRating, imdbVotes, imdbID: String?
    let type, dvd, boxOffice, production: String?
    let website, response: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case imdbRating
        case imdbVotes
        case imdbID
    }
}

