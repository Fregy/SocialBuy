//
//  ScannerViewController.swift
//  Social Buy
//
//  Created by Luis Sanjuan on 11/10/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import UIKit
import Social

protocol ScannerDelegate{
    func didScanProduct(item: Product)
}

class ScannerViewController: UIViewController,ParsingHelperDelegate {
    
    var delegate: ScannerDelegate?
    
    @IBOutlet var imageScanner: UIImageView!
    
    let parsingHelper = ParsingHelper();
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        parsingHelper.delegate = self
        
        self.simulateScanRandomProduct()
        
        }
    func simulateScanRandomProduct(){
        //Simulate that the camera read an ID then pass this ID for request to the server and the server responds me
        var k: Int = random() % 3;
        k++
        print("Estoy pasando: " + String(k))
        self.readFileJSON(k)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didParsingItem(item: Product){
        self.itemScanned(item)
        
    }
    
    func itemScanned(item:Product){

        imageScanner.image = UIImage(named: "item" + String(item.id))
        let alertController = UIAlertController(title: item.name, message: "Price " + String(item.price), preferredStyle: .Alert)
        
        let buyAction = UIAlertAction(title: "Buy", style: .Default) { (action) in
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.delegate?.didScanProduct(item)
            })
            self.simulateScanRandomProduct()
        }
        alertController.addAction(buyAction)
        
        let postAction = UIAlertAction(title: "Post", style: .Default) { (action) in
            self.postItem()
        }
        alertController.addAction(postAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
    
        }
        alertController.addAction(cancelAction)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(alertController, animated: true) {}
            })
        
    }
    
    
    func postItem(){
        let alertController = UIAlertController(title: "Share", message: "Choose a social network", preferredStyle: .Alert)
        
        let twitterAction = UIAlertAction(title: "Twitter", style: .Default) { (action) in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
                let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterSheet.setInitialText("#SocialBuy")
                twitterSheet.addImage(self.imageScanner.image!)
                self.presentViewController(twitterSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
        alertController.addAction(twitterAction)
        
        let facebookAction = UIAlertAction(title: "Facebook", style: .Cancel) { (action) in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookSheet.setInitialText("#SocialBuy")
                facebookSheet.addImage(self.imageScanner.image!)
                self.presentViewController(facebookSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        alertController.addAction(facebookAction)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(alertController, animated: true) {}
        })
        
    }
    
    
    func readFileJSON(num: Int){
        let file = "item" + String(num)//this is the file. we will read from it
        var text = ""
        if let path = NSBundle.mainBundle().pathForResource(file, ofType:"json"){
            //reading
            do {
                text = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
            }
            catch {/* error handling here */}
        }
        if text != ""{
            let data = text.dataUsingEncoding(NSUTF8StringEncoding)
            parsingHelper.parseData(data!)
            
        }
    }
    
    
    @IBAction func cancelScanner(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
