//
//  JSONParser.swift
//  MyFinalProject
//
//  Created by MCS on 11/11/15.
//  Copyright © 2015 MCS. All rights reserved.
//


//import UIKit
//class StoreCell: UICollectionViewCell {
//
//    @IBOutlet var imageViewCell: UIImageView!
//}
import UIKit
class JSONParser {
    let myDicc :NSMutableArray = []
   
    //This function is when we try to get information from URL
//    func jsonParsingFromURL () {
//    let url = NSURL(string: "http://")
//    let request = NSURLRequest(URL: url!)
//    
//    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
//    self.startParsing(data!)
//        }
//    }
    
    func jsonParsingFromFile()
    {
        let path: NSString = NSBundle.mainBundle().pathForResource("DraftJSONFile", ofType: "json")!
        let data : NSData = try! NSData(contentsOfFile: path as String, options: NSDataReadingOptions.DataReadingMapped)
        
        self.startParsing(data)
    }
    
    func startParsing(data :NSData)
    {
        

        let dict: NSDictionary!=(try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        
        //myDicc = dict
        
        //print(dict.valueForKey("Stores"))
        
    
            myDicc.addObject(dict.valueForKey("Stores")!)
        
        //print(myDicc)
        
    }

    
    

   }