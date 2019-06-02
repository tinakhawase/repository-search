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
    let networkService: NetworkRequestProviding
    
    // mandatory init for DetailsViewModel
    required init(observer: DetailsViewModelObserving, networkService: NetworkRequestProviding) {
        self.observer = observer
        self.networkService = networkService
    }
    
    // fetchSubscribers will call the fetchSubscribers from the network service
    // upon success the completion handler defined below will have a result
    func fetchSubscribers(repository: Repository) {
        //
        networkService.fetchSubscribers(repository: repository) { [weak self] (success, result) in
            if success, let response = result as? [SubscibersModelElement] {
                self?.subscribers = response
                DispatchQueue.main.async { [weak self] in
                    self?.observer.updateSubscriberResults()
                }
            } else {
                // error
            }
        }
    }
    
    // get the Subscriber model at a perticular index
    func getItemAt(index: Int) -> SubscibersModelElement {
        return self.subscribers[index]
    }
}
