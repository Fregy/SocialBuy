//
//  PurchaseProductCell.swift
//  Social Buy
//
//  Created by MCS on 11/10/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import UIKit
protocol PurchaseProductCellDelegate {
    func didChangeQty(qty:Int, ofProduct:Int)
}

class PurchaseProductCell: UITableViewCell {
    
    var delegate : PurchaseProductCellDelegate?
    
    @IBOutlet var imageItem: UIView!
    @IBOutlet var nameItem: UILabel!
    @IBOutlet var descItem: UILabel!
    @IBOutlet var priceItem: UILabel!
    @IBOutlet var qtyItem: UILabel!
    @IBOutlet var stepperQtyItem: UIStepper!
    @IBOutlet var subtotalItem: UILabel!
    
    var productId = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func modifyQuantity(sender: UIStepper) {
        var sub : Double = Double(priceItem.text!)!
        sub = sub * Double(sender.value)
        qtyItem.text = String(Int(sender.value))
        subtotalItem.text = String(sub)
        
        self.delegate?.didChangeQty(Int(sender.value), ofProduct: productId)
    }

}
