//
//  ParsingXML.swift
//  Social Buy
//
//  Created by Luis Sanjuan on 11/12/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import UIKit

protocol ParsingHelperDelegate{
    func didParsingItem(item: Product)
}

class ParsingHelper: NSObject, NSXMLParserDelegate {
    
    var delegate: ParsingHelperDelegate?
    var item: Product = Product()
    

    func parseData(data: NSData) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            do {
                let infoDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let responseData : NSDictionary = infoDictionary.valueForKey("item") as! NSDictionary
                self.item.id = responseData.valueForKey("id") as! Int
                self.item.name = responseData.valueForKey("name") as! String
                self.item.desc = responseData.valueForKey("description") as! String
                //self.item.discount = responseData.valueForKey("discount") as! Bool
                //self.item.discount = responseData.valueForKey("discount") as! Double
                self.item.price = responseData.valueForKey("price") as! Double
                self.item.quantity = responseData.valueForKey("quantity") as! Int
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.delegate?.didParsingItem(self.item)
                });
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        });
    }
}

