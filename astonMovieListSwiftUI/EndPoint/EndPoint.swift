import Foundation

struct EndPoint {
    
    static func getMovieUrl(film: String) -> URL {
        let url = URL(string: "http://www.omdbapi.com/?i=\(film)&apikey=b3465f6f")!
        return url
    }
}

