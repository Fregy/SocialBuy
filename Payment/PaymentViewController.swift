//
//  PaymentViewController.swift
//  Payment
//
//  Created by MCS on 11/10/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    var myArrayItems: [Product] = []
    
    var myTotal                = String(900.95)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Segue Function
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let stringItems = parsinItemsList(myArrayItems)
        
         SwiftSpinner.showWithDelay(0.0, title: "Retrieving Information...")
        
        if segue.identifier == "chashierSegue"{
            
            let vc          = segue.destinationViewController as! CashierViewController
            
            vc.stringItems  = stringItems
            vc.myTotal      = myTotal
            vc.myArrayItems = myArrayItems
            
        } else if segue.identifier == "cardSegue" {
            
            let vc          = segue.destinationViewController as! CardViewController
            
            vc.stringItems  = stringItems
            vc.myTotal      = myTotal
            vc.myArrayItems = myArrayItems
            
        }
    }
    
    func parsinItemsList(arrayItems:[Product])->String {
        
        var auxString = ""
        
        for item in arrayItems {
            
            auxString = auxString + String(item.id) + "\n"
            auxString = auxString + item.name + "\n"
            auxString = auxString + item.desc + "\n"
            auxString = auxString + String(item.price) + "\n"

        }
        
        return auxString
    }
    
    func setCloseTimer() {
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "close", userInfo: nil, repeats: false)
    }
    
    @IBAction func bBack(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
