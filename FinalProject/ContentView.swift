import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            PopularView()
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("HOT")
                }
            NowPlayingView()
                .tabItem {
                    Image(systemName: "play.fill")
                    Text("COME OUT")
                }
            UpComingView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("COMING SOON")
                }
            TopRatedView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("TOP RATE")
                }
            SearchBarView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("SEARCH")
                }
        }
        .accentColor(Color(.red))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
