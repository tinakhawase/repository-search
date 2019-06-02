//
//  RepositoryViewModelConfirming.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 30.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import Foundation

// The RepositoryViewModel should implement this protocol
protocol RepositoryViewModelConfirming {
    // store the items from n/w here
    var items: [Repository] { get }
    // Ask the VM for the search results; called from
    func performSearch(searchTerm: String)
    // this is called by the tableView from cellForRowAt:indexPath
    func getItemAt(index: Int) -> Repository
    // this is for the navigation to the Details; the VM should take all decisions no matter what
    func didSelectRepository(at index: Int)
    // this will clear all the items
    func clearAllItems()
    // When you init a VM, pass the `self` of the VC as the observer/delegate
    init(observer: RepositoryViewModelObserving, networkService: NetworkRequestProviding)
}
