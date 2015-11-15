//
//  ScansCell.swift
//  FinalProjectV1
//
//  Created by MCS on 11/15/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

import UIKit

class ScansCell: UITableViewCell {

    @IBOutlet var imageScans: UIImageView!
    @IBOutlet var nameScans: UILabel!
    @IBOutlet var detailScans: UILabel!
    @IBOutlet var statusScans: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
