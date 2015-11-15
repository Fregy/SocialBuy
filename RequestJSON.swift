//
//  RequestJSON.swift
//  Payment
//
//  Created by Luis Sanjuan on 11/15/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import UIKit
protocol RequestJSONDelegate{
    func didRequestJSON(item: Product)
}
class RequestJSON: NSObject, ParsingHelperDelegate {

    var delegate: RequestJSONDelegate?
    var parsingHelper = ParsingHelper();
    
    override init() {
        super.init()
        parsingHelper.delegate = self;
    }
    
    
    
    func requestJSON(num: Int){
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
    
    func didParsingItem(item: Product){
        self.delegate?.didRequestJSON(item)
    }
}
