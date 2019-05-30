//
//  DetailsViewModel.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 30.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import Foundation

// DetailsViewModel confirming to DetailsViewModelConfirming
class DetailsViewModel : DetailsViewModelConfirming{
    var subscribers = [SubscibersModelElement]()
    private var observer: DetailsViewModelObserving!
    
    func fetchSubscribers(repository: Repository) {
        let baseUrl = URL(string: repository.subscribersURL)!
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "GET"
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let serverResponse = try? decoder.decode([SubscibersModelElement].self, from: data),
                let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                // reload the tableView
                DispatchQueue.main.async { [weak self] in
                    let response = serverResponse as [SubscibersModelElement]
                    self?.subscribers = response
                    self?.observer.updateSubscriberResults()
                }
            }
        }
        
        task.resume()
        
    }
    
    func getItemAt(index: Int) -> SubscibersModelElement {
        return self.subscribers[index]
    }
    
    required init(observer: DetailsViewModelObserving) {
        self.observer = observer
    }
}
