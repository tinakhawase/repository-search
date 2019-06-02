//
//  NetworkRequestProviding.swift
//  GithubRepoSearchApp
//
//  Created by Deepashri Khawase on 31.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import Foundation

protocol NetworkRequestProviding {
    // performSearch will search for the repositories based on the search term
    func performSearch(searchTerm: String, completionBlock: @escaping completionHandler ) -> Void
    
     // fetchSubscribers will fetch all the subscribers from the subscribers URL
    func fetchSubscribers(repository: Repository, completionBlock: @escaping completionHandler) -> Void
}
