//
//  ViewController.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 27.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UIViewController {
    // lazy initialization of RepositoryViewModel insatnce which is confirming to RepositoryViewModelConfirming
    private(set) lazy var viewModel:RepositoryViewModelConfirming = {
        let _networkService = NetworkRequest()
        let _vm = RepositoryViewModel(observer:self, networkService: _networkService)
        return _vm
    }()
  
    @IBOutlet var searchControl: UISearchBar!
    @IBOutlet var tableview: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        searchControl.delegate = self
    }
}

// ViewController implementing UITableViewDelegate
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectRepository(at: indexPath.row)
    }
}

// ViewController implementing UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
         return self.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        tableView.rowHeight = UITableView.automaticDimension
        let cellAtCurrentIndex = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListItemControllerTableViewCell
       
        let repository = self.viewModel.getItemAt(index:indexPath.row)
        cellAtCurrentIndex.namelabel.text = repository.name
        cellAtCurrentIndex.descriptionlbl.text = repository.itemDescription
        cellAtCurrentIndex.forkslbl.text = String(repository.forksCount)
        
        let ownerAvatarUrl = repository.owner.avatarURL
        if let imageUrl = URL(string: ownerAvatarUrl) {
            cellAtCurrentIndex.Imageview.kf.setImage(with: imageUrl)
        }
        return cellAtCurrentIndex
    }
}

// ViewController implementing UISearchBarDelegate
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text!.count > 0{
            self.viewModel.performSearch(searchTerm: searchBar.text!)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.viewModel.clearAllItems()
    }
}

// ViewController implementing RepositoryViewModelObserving
extension ViewController:RepositoryViewModelObserving{
    // this method will be called from the VM to notify VC that data is available and you can load it now
    func updateSearchResults() {
       self.tableview.reloadData()
    }
    
    // this method will be called from the VM to notify VC that it can navigate to the DVC with the repository it returned
    func navigateToDetail(with data: Repository) {
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as!
        DetailViewController
        detailsVC.repository = data
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
