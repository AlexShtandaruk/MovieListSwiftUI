import Foundation

struct ProjectConstant {
    
    //MARK: - Images
    
    struct Images {
        static let logIn = "logIn"
        
        struct SideTabBar {
            static let home = "house"
            static let notification = "bell.badge"
            static let settings = "gearshape.fill"
            static let history = "clock.arrow.circlepath"
            static let help = "questionmark.circle"
            static let logOut = "rectangle.righthalf.inset.fill.arrow.right"
        }
    }
    
    //MARK: - SideTabBar
    
    struct SideTabBar {
        
        static let home = "Home"
        static let notification = "Notification"
        static let settings = "Settings"
        static let history = "History"
        static let help = "Help"
        static let logOut = "Log out"
    }
    
    //MARK: - Mock data
    
    static let mockData = Movie(title: "Title of movie", year: "1970", rated: "rated", released: "released", runtime: "130 min",genre: "genre", director: "director", writer: "writer", actors: "actors",  plot: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O., but his tragic past may doom the project and his team to disaster", language: "language", country: "country", awards: "awards", poster: "https://m.media-amazon.com/images/M/MV5BNWIwODRlZTUtY2U3ZS00Yzg1LWJhNzYtMmZiYmEyNmU1NjMzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg", ratings: [mockRating], metascore: "ratings", imdbRating: "imdbRating", imdbVotes: "imdbVotes", imdbID: "imdbID", type: "type", dvd: "dvd", boxOffice: "boxOffice", production: "production", website: "website", response: "response")
    
    static let mockRating = Rating(source: "source", value: "value")
    
    
}
