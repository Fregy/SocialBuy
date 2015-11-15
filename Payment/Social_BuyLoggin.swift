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
        print(imageFromSegue)
        
        
        
    }
    
    //Mark Actions
    @IBAction func buttonFacebookLoggin(sender: UIButton) {
        if(SocialNetwork == false){
            SocialNetwork = true
            labelDummySocialNetwork.text = "Social activated"
        }else{
            SocialNetwork = false
            labelDummySocialNetwork.text = "Social NO activated"
        }
        
        
    }
    @IBAction func buttonTwitterLoggin(sender: UIButton) {
        if(SocialNetwork == false){
            SocialNetwork = true
            labelDummySocialNetwork.text = "Social activated"
        }else{
            SocialNetwork = false
            labelDummySocialNetwork.text = "Social NO activated"
        }
       
    }
    @IBAction func buttonStoreLoggin(sender: UIButton) {
        //Validate tge loggin and go to regio's scene
        //SocialNetwork true/False
    }
    @IBAction func buttonSkipAll(sender: UIButton) {
        if(self.buttonTwitterObject.selected == false){
            if(self.buttonFacebbokObject.selected == false){
                //GO to the JC's scene
            }
        }
        //////code to sent the data to regio's scene
//        SocialNetwork = true/false
//        self.navigationController?.pushViewController(sceneLoggin, animated: true)
//        let tempStringImage = imagesArray.objectAtIndex(indexPath.row)
//        
//        sceneLoggin.imageFromSegue = tempStringImage as! NSString
        
        
    }
}
