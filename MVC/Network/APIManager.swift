import Foundation

class APIManager {
    static let shared = APIManager()
    
    func getDataFromServer(url: String, closure: @escaping ((Data?) -> ()) ) {
        
        guard let serverURL = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: serverURL) ) { data, response, error in
            if error != nil {
                return
            }
            
            closure(data)
        }.resume()
    }
}
