//
//  DetailsViewModelObserving.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 30.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import Foundation

// The DetailsViewController should implement this, and assign itself as the delegate of the VM
protocol DetailsViewModelObserving {
    // update the delegate/observer to update the results; this method will call `reloadData()`
    func updateSubscriberResults()
}
