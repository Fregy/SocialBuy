//
//  cellSocialNetwork.swift
//  FinalProjectV1
//
//  Created by MCS on 11/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

import UIKit

class cellSocialNetwork: UITableViewCell {

    
    @IBOutlet var imageNetwork: UIImageView!
    
    @IBOutlet var namePoster: UILabel!
    @IBOutlet var post: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
