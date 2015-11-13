//
//  NavigationPayment.swift
//  Payment
//
//  Created by MCS on 11/13/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import UIKit

class NavigationPayment: UINavigationController {

var myArrayItems: [Product]!
    
    // Segue Function
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let vc          = segue.destinationViewController as! PaymentViewController
    
        vc.myArrayItems = myArrayItems
    }
}