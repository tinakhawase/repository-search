//
//  RepositoryViewModel.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 30.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import Foundation

// RepositoryViewModel confirming to RepositoryViewModelConfirming
class RepositoryViewModel:RepositoryViewModelConfirming {
    var items = [Repository]()
    private var observer:RepositoryViewModelObserving!
    let networkService: NetworkRequestProviding
    
    // mandatory init for RepositoryViewModel
    required init(observer: RepositoryViewModelObserving, networkService: NetworkRequestProviding) {
        self.observer = observer
        self.networkService = networkService
    }
    
    // perform search will call the performsearch from the network service
    // upon success the completion handler defined below will have a result
    func performSearch(searchTerm: String) {
        networkService.performSearch(searchTerm: searchTerm) { [weak self] (success, result) in
            if success, let response = result as? RepositoryResponse {
                self?.items = response.items
                self?.observer.updateSearchResults()
            } else {
                // error
            }
        }
    }
    
    // get the Repository model at a perticular index
    func getItemAt(index: Int) -> Repository{
        return self.items[index]
    }
    
    // notify the VC to navigate to DVC with the given repository at the index
    func didSelectRepository(at index: Int) {
        self.observer.navigateToDetail(with: items[index])
    }
    
    // clear all the items from the internal lists
    func clearAllItems(){
        self.items.removeAll()
        self.observer.updateSearchResults()
    }
}
