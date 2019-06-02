//
//  NetworkRequest
//  RepoSearch
//
//  Created by Deepashri Khawase on 27.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.

import Foundation

typealias completionHandler = (Bool, AnyObject) -> Void

class NetworkRequest: NetworkRequestProviding {
    
    // performSearch will search for the repositories based on the search term
    func performSearch(searchTerm: String, completionBlock: @escaping completionHandler ) -> Void {
        guard let baseUrl = URL(string: "https://api.github.com/search/repositories?q=\(searchTerm)")
            else {
                // Return notifying that the URL is malformed
                completionBlock(false, NSError(domain: "Malformed URL", code: 404, userInfo: nil))
                return
        }
        
        var request = URLRequest(url: baseUrl)
        
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.mercy-preview+json", forHTTPHeaderField: "Accept")
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let serverResponse = try? decoder.decode(RepositoryResponse.self, from: data),
                let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                // Success!
                completionBlock(true, serverResponse as AnyObject)
            } else {
                completionBlock(false, NSError(domain: "Malformed URL", code: 123, userInfo: nil))
            }
        }
        task.resume()
    }
    
    // fetchSubscribers will fetch all the subscribers from the subscribers URL
    func fetchSubscribers(repository: Repository, completionBlock: @escaping completionHandler) -> Void {
        guard let baseUrl = URL(string: repository.subscribersURL)
            else {
                // Return notifying that the URL is malformed
                completionBlock(false, NSError(domain: "Malformed URL", code: 404, userInfo: nil))
                return
        }
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "GET"
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let serverResponse = try? decoder.decode([SubscibersModelElement].self, from: data),
                let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                completionBlock(true, serverResponse as AnyObject)
            } else {
                completionBlock(false, NSError(domain: "Malformed URL", code: 123, userInfo: nil))
            }
        }
        task.resume()
    }
}

