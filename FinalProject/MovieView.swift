import SwiftUI

struct MovieView: View {
    
    @State private var movies = [Movie]()
    @State private var pick = 0
    let urls = ["https://api.themoviedb.org/3/movie/popular?api_key=b4e4f2b43d86e1779e3a1e347c7ad534&language=zh-TW&page=1", "https://api.themoviedb.org/3/movie/now_playing?api_key=b4e4f2b43d86e1779e3a1e347c7ad534&language=zh-TW&page=1", "https://api.themoviedb.org/3/movie/upcoming?api_key=b4e4f2b43d86e1779e3a1e347c7ad534&language=zh-TW&page=1", "https://api.themoviedb.org/3/movie/top_rated?api_key=b4e4f2b43d86e1779e3a1e347c7ad534&language=zh-TW&page=1"]
    let popularUrl = "https://api.themoviedb.org/3/movie/popular?api_key=b4e4f2b43d86e1779e3a1e347c7ad534&language=zh-TW&page=1"
    let nowPlayingUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=b4e4f2b43d86e1779e3a1e347c7ad534&language=zh-TW&page=1"
    let upComingUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=b4e4f2b43d86e1779e3a1e347c7ad534&language=zh-TW&page=1"
    let topRatedUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=b4e4f2b43d86e1779e3a1e347c7ad534&language=zh-TW&page=1"
    
    func fetchMovies(pick: Int) {
        var urlStr = ""
        urlStr = urls[pick]
        
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data,
                   let MovieResults = try? decoder.decode(MovieResults.self, from: data) {
                    movies = MovieResults.results
                    
                }
                else {
                    print(data, response, error)
                }
                
            }.resume()
        }
    }
    
    var body: some View {
        VStack{
            Text("電影列表")
                .font(.title)
                .fontWeight(.bold)
            Picker("test", selection: self.$pick){
                ForEach(movietype.indices) { (index) in
                    Text(movietype[index])
                }
            }.pickerStyle(SegmentedPickerStyle())
            NavigationView {
                List(movies.indices, id:\.self, rowContent: { (index) in
                    NavigationLink(
                        destination: MovieDetail(movie: movies[index]),
                        label: {MovieRow(movie: movies[index])
                        })
                })
                .onAppear(perform: {
                    fetchMovies(pick: pick)
                })
                .navigationTitle(movietype[pick])
            }
        }
        
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
