import SwiftUI

struct MovieDetail: View {
    @State private var isSharePresented: Bool = false
    var movie: Movie
    @State private var scale: CGFloat = 1
    @State private var newScale: CGFloat = 1
    
    var body: some View {
        VStack {
            NetworkImage(url: URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(movie.backdrop_path)")!)
                .scaledToFit()
            List {
                Section(header: Text("電影名稱")) {
                    Text(movie.title + "（\(movie.original_title)）")
                }
                Section(header: Text("上映日期")) {
                    Text(movie.release_date)
                }
                Section(header: Text("概要")) {
                    Text(movie.overview)
                }
            }
            
        }
        .animation(.linear(duration:1))
        .navigationTitle(Text(movie.title))
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.isSharePresented = true
                                }) {
                                    Image(systemName: "square.and.arrow.up")
                                }.sheet(isPresented: $isSharePresented, onDismiss: {
                                    print("Dismiss")
                                }, content: {
                                    ActivityViewController(activityItems: [URL(string: "https://www.themoviedb.org/movie/\(movie.id)")!])
                                })
                    )
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: Movie(id: 540464, title: "aa", original_title: "bb", backdrop_path: URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/kf456ZqeC45XTvo6W9pW5clYKfQ.jpg")!, release_date: "2000-11-11", overview: "overview test")
        )
    }
}
