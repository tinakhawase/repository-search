//
//  DetailViewController.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 29.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // lazy initialization of DetailsViewModel insatnce which is confirming to DetailsViewModelConfirming
    private(set) lazy var viewModel:DetailsViewModelConfirming = {
        let _networkController = NetworkRequest()
        let _vm = DetailsViewModel(observer : self, networkService: _networkController)
        return _vm
    }()
    var repository: Repository?
    
    @IBOutlet weak var SubscribersTableView: UITableView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label1a: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SubscribersTableView.dataSource = self
        SubscribersTableView.delegate = self
        self.viewModel.fetchSubscribers(repository: self.repository!)

    }
}

// DetailViewController implementing UITableViewDelegate
extension DetailViewController : UITableViewDelegate {
    
}

// DetailViewController implementing UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.viewModel.subscribers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellAtCurrentIndex = tableView.dequeueReusableCell(withIdentifier: "SubscribersCell", for: indexPath) as! SubscriberCellView
        let subscriber = self.viewModel.getItemAt(index: indexPath.row)
        cellAtCurrentIndex.textLabel!.text = subscriber.login
        return cellAtCurrentIndex
    }
}

// SubscriberCellView implementing UITableViewCell
// indicate the cell in DVC table view
class SubscriberCellView: UITableViewCell {
    
}

// DetailViewController implementing DetailsViewModelObserving
extension DetailViewController:DetailsViewModelObserving{
    // this method will be called from the DVM to inform DVC that the subscriber data is now available to load into the UI elements
    func updateSubscriberResults() {
        self.label1.text = self.repository!.name
        self.label1a.text = String(self.viewModel.subscribers.count)
        self.SubscribersTableView.reloadData()
    }}
