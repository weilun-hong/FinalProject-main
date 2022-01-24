import Foundation

struct MovieResults: Codable, Hashable {
    let results: [Movie]
}
struct Genres: Codable {
    let id: Int!
    let name: String!
}

struct Movie: Codable, Hashable {
    let id: Int
    let title: String
    let original_title: String
    let backdrop_path: URL
    let release_date: String
    let overview: String
}

let movietype: [String] = ["HOT", "COME OUT", "COMING SOON", "TOP RATE"]
