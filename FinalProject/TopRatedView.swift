import SwiftUI

struct TopRatedView: View {
    @State private var movies = [Movie]()
    @State private var showPersonal: Bool = false
    
    func fetchTopRatedMovies() {
        let urlStr = "https://api.themoviedb.org/3/movie/top_rated?api_key=b4e4f2b43d86e1779e3a1e347c7ad534&language=zh-TW&page=1"
        
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data,
                   let MovieResults = try? decoder.decode(MovieResults.self, from: data) {
                    movies = MovieResults.results
                    
                }
                else {
                    print("error")
                }
                
            }.resume()
        }
    }
    
    var body: some View {
        NavigationView {
            List(movies.indices, id:\.self, rowContent: { (index) in
                NavigationLink(
                    destination: MovieDetail(movie: movies[index]),
                    label: {MovieRow(movie: movies[index])
                    })
            })
            .onAppear(perform: {
                fetchTopRatedMovies()
            })
            .navigationTitle(Text("TOP RATE"))
        }
        
    }
}

struct TopRatedView_Previews: PreviewProvider {
    static var previews: some View {
        TopRatedView()
    }
}
