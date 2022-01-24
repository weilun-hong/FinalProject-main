import SwiftUI

struct SearchBar : UIViewRepresentable {
    @Binding var text : String
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        text = searchText
    }
    
    func makeCoordinator() -> Cordinator {
        return Cordinator(text: $text)
    }
    func makeUIView(context: UIViewRepresentableContext<SearchBar>)
    -> UISearchBar {
        
        let searchBar = UISearchBar(frame: .zero)
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.delegate = context.coordinator
        return searchBar
    }
    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    class Cordinator : NSObject, UISearchBarDelegate {
        @Binding var text : String
        init(text : Binding<String>)
        {
            _text = text
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
        {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
        }
    }
}

struct SearchBarView: View {
    let djs = [
        "彼得潘好帥",
        "讚嘆彼得潘",
        "謝謝彼得潘這半年的教導",
        "安捏有加分嗎？",
        "顆顆",
      ]
      @State private var searchTerm : String = ""
      
      var body: some View {
        NavigationView{
          List {
            SearchBar(text: $searchTerm)
            ForEach(self.djs.filter { self.searchTerm.isEmpty ? true : $0.contains(self.searchTerm) }, id: \.self) { name in
              Text(name)
            }
          }
          .navigationBarTitle(Text("SEARCH"))
          .navigationBarTitleDisplayMode(.inline)
        }
      }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
