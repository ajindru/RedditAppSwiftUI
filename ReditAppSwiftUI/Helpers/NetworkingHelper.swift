import UIKit
import Combine

class NetworkingHelper {
    
    enum Constants {
        static let baseURL = "http://www.reddit.com/.json"
        static let afterURL = baseURL + "?after="
    }
    
    var didChange = PassthroughSubject<RedditData, Never>()
    var didSetCurrent = PassthroughSubject<String, Never>()
    
    var redditData = RedditData() {
        didSet {
            didChange.send(redditData)
        }
    }
    
    func getData() {
        executeRequest(with: Constants.baseURL)
    }
    
    func refreshData(with after: String) {
        let urlString = Constants.afterURL + after
        executeRequest(with: urlString)
    }
    
    private func executeRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                // Error Handling if required.
            } else {
                guard let data = data else { return }
                
                let redditJSON = try! JSONDecoder().decode(RedditJSON.self, from: data)
                
                DispatchQueue.main.async {
                    self.redditData = redditJSON.data ?? RedditData()
                }
            }
        }.resume()
    }
}
