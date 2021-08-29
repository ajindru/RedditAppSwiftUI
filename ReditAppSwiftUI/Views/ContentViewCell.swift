import SwiftUI

struct ContentViewCell: View {
    @ObservedObject var imageHelper: ImageHelper
    @State var image = UIImage()

    var post: RedditPost
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(post.linkFlair ?? "")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Text(post.subreddit ?? "")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            Text(post.title ?? "")
                .font(.headline)
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onReceive(imageHelper.didChange) {
                    self.image = UIImage(data: $0) ?? UIImage()
                }
            HStack(alignment: .center) {
                Image(systemName: "arrow.up")
                    .resizable()
                    .frame(width:12,height:12)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                Text(String(post.ups ?? 0))
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                Image(systemName: "arrow.down")
                    .resizable()
                    .frame(width:12,height:12)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                Text(String(post.downs ?? 0))
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
            }
        }
    }
}
