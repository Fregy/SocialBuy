//
//  TableViewCell.swift
//  FinalProjectV1
//
//  Created by MCS on 11/10/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var imageItem: UIImageView!
    @IBOutlet var titleItem: UILabel!
    @IBOutlet var descriptionItem: UILabel!
    @IBOutlet var priceITem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
