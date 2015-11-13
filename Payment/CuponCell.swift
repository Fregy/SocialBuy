//
//  CuponCell.swift
//  SocialBuy
//
//  Created by MCS on 11/11/15.
//  Copyright © 2015 MCS_batch4. All rights reserved.
//

import UIKit


class CuponCell: UITableViewCell {

    
    
    @IBOutlet var cuponId: UILabel!
    @IBOutlet var cuponDescription: UILabel!
    @IBOutlet var cuponValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
