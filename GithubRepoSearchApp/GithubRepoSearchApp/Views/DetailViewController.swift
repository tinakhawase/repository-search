//
//  DetailViewController.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 29.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private(set) lazy var viewModel:DetailsViewModelConfirming = {
        let _vm = DetailsViewModel(observer : self)
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

// DetailViewController
extension DetailViewController : UITableViewDelegate {
    
}

// DetailViewController
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

// SubscriberCellView
class SubscriberCellView: UITableViewCell {
    
}

extension DetailViewController:DetailsViewModelObserving{
    func updateSubscriberResults() {
        self.label1.text = self.repository!.name
        self.label1a.text = String(self.viewModel.subscribers.count)
        self.SubscribersTableView.reloadData()
    }
}
