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
    
    

    func parseData(data: NSData) {
        //let item: Product = Product()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            do {
                let item: Product = Product()
                let infoDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let responseData : NSDictionary = infoDictionary.valueForKey("item") as! NSDictionary
                
                item.id = responseData.valueForKey("id") as! Int
                item.name = responseData.valueForKey("name") as! String
                item.desc = responseData.valueForKey("description") as! String
                item.discount = responseData.valueForKey("discount") as! Bool
                //self.item.discount = responseData.valueForKey("discount") as! Double
                item.price = responseData.valueForKey("price") as! Double
                item.quantity = responseData.valueForKey("quantity") as! Int
                
                dispatch_sync(dispatch_get_main_queue(), {
                    self.delegate?.didParsingItem(item)
                });
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        });
    }
}

