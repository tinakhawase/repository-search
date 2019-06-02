//
//  RepositoryViewModelObserving.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 30.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import Foundation

// The ViewController should implement this, and assign itself as the delegate of the VM
protocol RepositoryViewModelObserving {
    // update the delegate/observer to update the results; this method will call `reloadData()`
    func updateSearchResults()
    // tell the VC to nevigate to the Details, and pass the Repo as the data
    func navigateToDetail(with data: Repository)
}
