//
//  CashierViewController.swift
//  Payment
//
//  Created by MCS on 11/10/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import UIKit

class CashierViewController: UIViewController {
    
    ///////////////////////////////////////////////
    @IBOutlet var imageQRCode: UIImageView!

    var stringItems:String   = ""
    var myTotal:String       = ""
    var mySaving:String      = ""
    var myArraySales: [Sale] = []

    var qrcodeImage: CIImage!
    
    var myDataBase: DataBase!
    ///////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true
        navigationController?.toolbarHidden = true
        
        SwiftSpinner.showWithDelay(0.0, title: "Retrieving Information...")
        
        delay(seconds: 3.0, completion: {
            SwiftSpinner.show("Go to the closer chasier", animated: false)
        })
        
        delay(seconds: 5.0, completion: {
            SwiftSpinner.hide({
                self.makeQRImage(self.stringItems, total: self.myTotal)
            })
        })
        
        delay(seconds: 15.0, completion: {
            SwiftSpinner.show("Done", animated: false)
        })
        
        delay(seconds: 20.0, completion: {
            SwiftSpinner.hide({
                self.insertSales(self.myArraySales)
                
                self.navigationController?.popToRootViewControllerAnimated(true)
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Function to Create QR Image
    func makeQRImage(items:String, total:String) {
        
        if qrcodeImage == nil {
            
            let auxString = items + "\n" + total
            
            let data = auxString.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter!.setValue(data, forKey: "inputMessage")
            filter!.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter!.outputImage
            
            displayQRCodeImage()
        }
        else {
            imageQRCode.image = nil
            qrcodeImage = nil
        }
    }
    // Function to Display a QR Image
    func displayQRCodeImage() {
        
        let scaleX = imageQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imageQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        imageQRCode.image = UIImage(CIImage: transformedImage)
    }
    // Function Delay
    func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    // Function Insert DataBase Data
    func insertSales(mySale:[Sale]) {
        
        for Item in mySale {
            myDataBase.insertSale("Sale", myItem: Item)
        }
    }
}