//
//  RepositoryViewModel.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 30.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import Foundation

class RepositoryViewModel:RepositoryViewModelConfirming {
    var items = [Repository]()
    private var observer:RepositoryViewModelObserving!
    
    func performSearch(searchTerm: String) {
        var baseUrl = URL(string: "https://api.github.com/search/repositories?q=\(searchTerm)")
        var request = URLRequest(url: baseUrl!)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.mercy-preview+json", forHTTPHeaderField: "Accept")
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let serverResponse = try? decoder.decode(RepositoryResponse.self, from: data),
                let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                // reload the tableView
                DispatchQueue.main.async { [weak self] in
                    let response = serverResponse as RepositoryResponse
                    self?.items = response.items
                    self?.observer.updateSearchResults()
                }
            }
        }
        task.resume()
    }
    
    func getItemAt(index: Int) -> Repository{
        return self.items[index]
    }
    
    func didSelectRepository(at index: Int) {
        self.observer.navigateToDetail(with: items[index])
    }
    
    required init(observer: RepositoryViewModelObserving) {
        self.observer = observer
    }
    
    func clearAllItems(){
        self.items.removeAll()
        self.observer.updateSearchResults()
    }
}
