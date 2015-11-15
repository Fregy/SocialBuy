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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc          = segue.destinationViewController as! PaymentViewController
        
        vc.myArrayItems = myArrayItems

    }
    
}