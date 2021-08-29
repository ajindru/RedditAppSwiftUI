import SwiftUI

struct ContentView: View {
    
    @State var posts: [RedditPost] = []
    @State var current = ""
    @State var currentIndex = -1
    let networkingHelper = NetworkingHelper()
    
    var body: some View {
        
        NavigationView {
            List(posts) { post in
                ContentViewCell(
                    imageHelper: ImageHelper(urlString: post.thumbnail ?? ""),
                    post: post
                )
                .onAppear() {
                    currentIndex += 1
                    if currentIndex == posts.count {
                        networkingHelper.refreshData(with: current)
                    }
                }
            }
            .navigationTitle("Reddit Posts")
            .onAppear {
                networkingHelper.getData()
            }
            .onReceive(networkingHelper.didChange) {
                if currentIndex == posts.count {
                    self.posts.append(
                        contentsOf: $0.children?.compactMap { $0.post } ?? []
                    )
                    print("Refreshed")
                } else {
                    self.posts = $0.children?.compactMap { $0.post } ?? []
                }
                self.current = $0.after ?? ""
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
