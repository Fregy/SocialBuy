//
//  DataBase.swift
//  Payment
//
//  Created by MCS on 11/12/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import Foundation
import CoreData

class DataBase: NSManagedObject {
    
//    func insertItem(nameTable:String, myItem:Product){
//        
//        let auxProduct = NSEntityDescription.insertNewObjectForEntityForName(nameTable,
//            inManagedObjectContext: self.managedObjectContext!) as! Product
//        
//        auxProduct.id       = myItem.id
//        auxProduct.name     = myItem.name
//        auxProduct.desc     = myItem.desc
//        auxProduct.price    = myItem.price
//        auxProduct.discount = myItem.discount
//        auxProduct.quantity = myItem.quantity
//        
//        do {
//            
//            try self.managedObjectContext!.save()
//            
//        } catch {
//            print("Unable to Insert")
//            abort()
//        }
//    }
    
    func insertSale(nameTable:String, myItem:Sale){
        
        let auxSale = NSEntityDescription.insertNewObjectForEntityForName(nameTable,
            inManagedObjectContext: self.managedObjectContext!) as! Sale
        
        auxSale.id       = myItem.id
        auxSale.quantity = myItem.quantity
        
        do {
            
            try self.managedObjectContext!.save()
            
        } catch {
            print("Unable to Insert")
            abort()
        }
    }
}