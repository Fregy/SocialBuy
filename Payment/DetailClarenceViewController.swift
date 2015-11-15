//
//  DetailClarenceViewController.swift
//  FinalProjectV1
//
//  Created by MCS on 11/11/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

import UIKit

class DetailClarenceViewController: UIViewController {
    
    //Outlets
    @IBOutlet var imageItem: UIImageView!
    @IBOutlet var titleItem: UILabel!
    @IBOutlet var descriptionItem: UILabel!
    @IBOutlet var itemPrice: UILabel!
    @IBOutlet var imageBacground: UIImageView!
    
    //Variables
    var titleItemSend: String!
    var descriptionItemSend: String!
    var itemPriceSend: String!
    var imageItemSend:UIImage? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Set data from parent view
        self.titleItem.text = titleItemSend
        self.imageItem.image = imageItemSend
        self.descriptionItem.text = descriptionItemSend
        self.itemPrice.text = itemPriceSend
        
        //Circle images
        self.imageBacground.layer.cornerRadius = self.imageItem.bounds.height / 4
        self.imageBacground.clipsToBounds = true
        
        //Border in images
        self.imageBacground.layer.borderWidth = 1
        self.imageBacground.layer.borderColor = UIColor.grayColor().CGColor
        

        //Shadow
        self.imageBacground.backgroundColor = UIColor.clearColor()
        self.imageBacground.layer.shadowColor = UIColor.darkGrayColor().CGColor
        //self.imageBacground.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12.0).CGPath
        self.imageBacground.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.imageBacground.layer.shadowOpacity = 1.0
        self.imageBacground.layer.shadowRadius = 2
        self.imageBacground.layer.masksToBounds = true
        self.imageBacground.clipsToBounds = false

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
