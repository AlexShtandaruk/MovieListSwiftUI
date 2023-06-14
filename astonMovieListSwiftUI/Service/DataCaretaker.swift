import Foundation

final class DataCaretaker {
    
    // MARK: - PROPERTIES
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    // MARK: - Static data caretaker method's
    
    func saveMovieList(_ movies: [Movie]) {
        do {
            let encodedMovies = try self.encoder.encode(movies)
            UserDefaults.standard.set(encodedMovies, forKey: Constant.movieListKey)
        } catch {
            debugPrint(String(describing: error))
        }
    }
    
    func loadMovieList() -> [Movie]? {
        guard let data = UserDefaults.standard.data(forKey: Constant.movieListKey) else { return nil }
        
        do {
            let movies = try self.decoder.decode([Movie].self, from: data)
            return movies
        } catch {
            debugPrint(String(describing: error))
            return nil
        }
    }
    
    // MARK: - Static authorization caretaker method's
    
    func authSave(_ auth: Bool) {
        UserDefaults.standard.set(auth, forKey: Constant.authKey)
    }
    
    func authStatus() -> Bool? {
        return UserDefaults.standard.bool(forKey: Constant.authKey)
    }
}

// MARK: - Constant's

extension DataCaretaker {
    enum Constant {
        static let movieListKey = "MovieList"
        static let authKey = "authKey"
    }
}

