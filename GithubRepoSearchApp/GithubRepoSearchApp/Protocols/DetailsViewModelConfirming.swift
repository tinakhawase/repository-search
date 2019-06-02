//
//  DetailsViewModelConfirming.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 30.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import Foundation
// The DetailsViewModel should implement this protocol
protocol DetailsViewModelConfirming {
    // subscribers from the network call
    var subscribers: [SubscibersModelElement] {get}
    // Ask the DVM for the subscribers for the repository; called from
    func fetchSubscribers(repository: Repository)
    // this is called by the tableView from cellForRowAt:indexPath
    func getItemAt(index: Int) -> SubscibersModelElement
    // When you init a DVM, pass the `self` of the DVC as the observer/delegate
    init(observer: DetailsViewModelObserving, networkService: NetworkRequestProviding)
}
