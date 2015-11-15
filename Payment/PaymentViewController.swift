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
    var myArraySales: [Sale]    = []
    
    var myTotal                 = ""
    var mySaving                = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        myArraySales = getSales(myArrayItems)
        mySaving     = getSaving(myArrayItems)
        myTotal      = getTotal(myArrayItems)
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
            vc.mySaving     = mySaving
            vc.myArraySales = myArraySales
            
        } else if segue.identifier == "cardSegue" {
            
            let vc          = segue.destinationViewController as! CardViewController
            
            vc.stringItems  = stringItems
            vc.myTotal      = myTotal
            vc.mySaving     = mySaving
            vc.myArraySales = myArraySales
            
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
    
    func getSales(listItems:[Product])->[Sale] {
        
        var auxSales = [Sale]()
        
        for item in  listItems {
            
            if !item.discount {
                
                let mySale      = Sale()
                
                mySale.id       = item.id
                mySale.quantity = item.quantity
                
                auxSales.append(mySale)
            }
            
        }
        
        return auxSales
    }
    
    func getTotal(listItems:[Product])->String {
        
        var auxTotal: Double = 0.0
        
        for item in  listItems {
            auxTotal += item.price*Double(item.quantity)
        }
        
        let tax  = (auxTotal)*(0.8)
        
        auxTotal = auxTotal + tax
        
        return String(auxTotal)
    }
    
    func getSaving(listItems:[Product])->String {
        
        var auxSaving: Double = 0.0
        
        for item in  listItems {
            if item.discount {
                auxSaving += item.price*Double(item.quantity)
            }
        }
        
        return String(auxSaving)
    }
    
    @IBAction func bBack(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
}
