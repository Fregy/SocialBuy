//
//  CardViewController.swift
//  Payment
//
//  Created by MCS on 11/10/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    ///////////////////////////////////////////////
    var spinnin = SwiftSpinner()
    
    var myCard = Card()
    
    var stringItems:String = ""
    var myTotal:String = ""
    var mySaving:String = ""
    var myArraySales: [Sale] = []
    
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfCardNumber: UITextField!
    @IBOutlet var tfMonthYear: UITextField!
    @IBOutlet var tfCVC: UITextField!
    @IBOutlet var tvListItems: UITextView!
    @IBOutlet var lbTotal: UILabel!
    
    var myDataBase: DataBase!
    ///////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true
        navigationController?.toolbarHidden = true
        
        SwiftSpinner.showWithDelay(0.0, title: "Retrieving Information...")
        
        delay(seconds: 3.0, completion: {
            SwiftSpinner.show("Done", animated: false)
        })
        
        delay(seconds: 5.0, completion: {
            SwiftSpinner.hide({
                self.tvListItems.text! = self.stringItems
                self.lbTotal.text      = "Total: $" + self.myTotal
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Button SendPayment to WebService
    @IBAction func bSendPayment(sender: UIButton) {
        
        if tfEmail.text != "" && tfCardNumber.text != "" &&
           tfMonthYear.text != "" && tfCVC.text != "" {
            
            myCard.email = tfEmail.text!
            myCard.email = tfCardNumber.text!
            myCard.email = tfMonthYear.text!
            myCard.email = tfCVC.text!
            
            // Split the expiration date to extract Month & Year
            if tfMonthYear.text == "" {
                let expirationDate = tfMonthYear.text!.componentsSeparatedByString("/")
                let expMonth = expirationDate[0]
                let expYear = expirationDate[1]
                
                // Send the card info to Strip to get the token
                myCard.number = tfCardNumber.text!
                myCard.cvc = tfCVC.text!
                myCard.expMonth = expMonth
                myCard.expYear = expYear
            }
            
            SwiftSpinner.showWithDelay(0.0, title: "Checking Card Information...")
            
            if checkCard(myCard) {

                delay(seconds: 3.0, completion: {
                    SwiftSpinner.show("Payment Acepted by" + self.myTotal, animated: false)
                })
                
                delay(seconds: 5.0, completion: {
                    SwiftSpinner.hide({
                    
                        self.tfEmail.text!      = ""
                        self.tfCardNumber.text! = ""
                        self.tfMonthYear.text!  = ""
                        self.tfCVC.text!        = ""
                        
                        self.insertSales(self.myArraySales)
                        
                        self.navigationController?.popToRootViewControllerAnimated(true)
                        
                        
                    })
                })
                
            } else {
                
                delay(seconds: 3.0, completion: {
                    SwiftSpinner.show("Card Declined", animated: false)
                })
                
                delay(seconds: 5.0, completion: {
                    SwiftSpinner.hide({
                    
                        self.tfEmail.text!      = ""
                        self.tfCardNumber.text! = ""
                        self.tfMonthYear.text!  = ""
                        self.tfCVC.text!        = ""
                        
                    })
                })
            }
            
        } else {
            displayMessage("Error", message: "Please Fill all the Information", buttonName: "Ok")
        }
        
    }
    // Function Checking if the card is aprove
    func checkCard(card:Card)->Bool {
        
        return true
    }
    // Function to Make an AlertView with one Button
    func displayMessage(title:String, message:String, buttonName:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: buttonName, style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    // Function Delay
    func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    // Function Insert DataBase Data
    func insertSales(myProducts:[Sale]) {
        
        for Item in myProducts {
            myDataBase.insertSale("Sale", myItem: Item)
        }
    }
}
