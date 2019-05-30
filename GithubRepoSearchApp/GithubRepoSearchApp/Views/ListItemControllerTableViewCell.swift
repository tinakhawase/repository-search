//
//  ListItemControllerTableViewCell.swift
//  RepoSearch
//
//  Created by Deepashri Khawase on 28.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import UIKit

class ListItemControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var Imageview: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var forkslbl: UILabel!
    @IBOutlet weak var descriptionlbl: UILabel!
    
   // internal var ownername : RepositoryResponse.Owner
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
