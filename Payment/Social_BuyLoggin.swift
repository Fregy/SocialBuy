//
//  LogginScene.swift
//  MyFinalProject
//
//  Created by MCS on 11/15/15.
//  Copyright © 2015 MCS. All rights reserved.
//

import UIKit

class Social_BuyLoggin: UIViewController{
    // Mark my Objects
    @IBOutlet var labelDummySocialNetwork: UILabel!
    @IBOutlet var imageViewStoreSelected: UIImageView!
    @IBOutlet var buttonTwitterObject: UIButton!
    @IBOutlet var buttonFacebbokObject: UIButton!
    @IBOutlet var textFieldStoreUserName: UITextField!
    @IBOutlet var textFieldStoreUserPassword: UITextField!
    var imageFromSegue = NSString()
    var SocialNetwork = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewStoreSelected.image = nil
        imageViewStoreSelected.image = UIImage(named: imageFromSegue as String)
        //print(imageFromSegue)
        
        
        
    }
    
    //Mark Actions
    @IBAction func buttonFacebookLoggin(sender: UIButton) {
        if(SocialNetwork == false){
            SocialNetwork = true
        }else{
            SocialNetwork = false
        }
        
        
    }
    @IBAction func buttonTwitterLoggin(sender: UIButton) {
        if(SocialNetwork == false){
            SocialNetwork = true
        }else{
            SocialNetwork = false
        }
       
    }
    @IBAction func buttonStoreLoggin(sender: UIButton) {
        //Validate tge loggin and go to regio's scene
        //SocialNetwork true/False
    }
    @IBAction func buttonSkipAll(sender: UIButton) {
        if(SocialNetwork == false){
            
        }
        if(SocialNetwork == true){
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toShoppingCart"){
            let shoppingCart = segue.destinationViewController as! ShoppingCarController
            //shoppingCart.storeName = imageFromSegue
        }
        else if(segue.identifier == "PromoR"){
            let promoR = segue.destinationViewController as! ViewController
            //promoR.storeName = imageFromSegue
            //promoR.SocialNetwork = SocialNetwork
        }
    }
    
}
