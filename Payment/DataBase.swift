//
//  DataBase.swift
//  Payment
//
//  Created by MCS on 11/12/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import UIKit
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
    
    func RetrieveItemsWithOutSales(SalesDone:[Int]) ->[Item]{
        
        //make instances
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //Instance manage object
        let managedContext = appDelegate.managedObjectContext
        
        //Cacth error
        var error: NSError?
        
        //Get elements from Item entity
        let fetchRequest = NSFetchRequest(entityName: "Items")
        let fetchResults: [AnyObject]?
        do {
            fetchResults = try managedContext.executeFetchRequest(fetchRequest)
        } catch let error1 as NSError {
            error = error1
            fetchResults = nil
        }
        
        
        var ItemsArray = [Item]()
        var existsId = false
        
        //Fetch elements from
        if fetchResults!.count > 0 {
            
            for result: AnyObject in fetchResults! {
                
                let ItemReload = Item()
                existsId = false
                
                //Get values from entity
                let id = result.valueForKey("id") as! Int
                let name = result.valueForKey("name") as! String
                let descriptionItem = result.valueForKey("descriptionItem") as! String
                let image = result.valueForKey("image") as! NSData
                let price = result.valueForKey("price") as! Float
                let goalLike = result.valueForKey("goalLike") as! Int
                let amountScans = result.valueForKey("amountScans") as! Int
                
                //Verifie if id exist in sales
                for idSales: AnyObject in SalesDone{
                    
                    if idSales as! Int == id{
                        existsId = true
                        break
                    }
                    
                }
                
                if existsId == true{
                    continue
                }
                
                //Set Values in class Item
                ItemReload.id = id
                ItemReload.name = name
                ItemReload.descriptionItem = descriptionItem
                ItemReload.image = image
                ItemReload.price = price
                ItemReload.goalLike = goalLike
                ItemReload.amountScans = amountScans
                
                //                println(id)
                //                println(name)
                //                println(descriptionItem)
                //                println(price)
                //                println(goalLike)
                //                println(amountScans)
                
                ItemsArray.append(ItemReload)
                
            }
            print("Finish")
            
            return ItemsArray
        }
        else {
            print("No data")
            return ItemsArray
        }
        //return ItemsArray
    }
    
    
    func InsertItem(id:Int, name:String, descriptionItem:String, image:UIImage, price: Float) {
        //make instances
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //Instance manage object
        let managedContext = appDelegate.managedObjectContext
        
        //Instance object Item
        let entity =  NSEntityDescription.entityForName("Items",inManagedObjectContext:managedContext)
        
        let Item = NSManagedObject(entity: entity!,insertIntoManagedObjectContext: managedContext)
        
        //Set data in repository
        Item.setValue(name, forKey: "name")
        Item.setValue(descriptionItem, forKey: "descriptionItem")
        Item.setValue(price, forKey: "price")
        Item.setValue(id, forKey: "id")
        
        //Set Image cast
        let imageData = NSData(data: UIImageJPEGRepresentation(image, 1.0)!)
        Item.setValue(imageData, forKey: "image")
        
        //        var goalLike = 0
        //        var amountScans = 10
        //
        //        if id == 1
        //        {
        //            goalLike = 3
        //
        //        }
        //        if id == 3
        //        {
        //            goalLike = 10
        //
        //        }
        //        if id == 6
        //        {
        //            goalLike = 5
        //        }
        //
        //        if id == 8
        //        {
        //            goalLike = 10
        //        }
        //
        //        if id == 9
        //        {
        //            goalLike = 4
        //        }
        //
        //        Item.setValue(goalLike, forKey: "goalLike")
        //        Item.setValue(amountScans, forKey: "amountScans")
        
        var error: NSError?
        do {
            //Save Item
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            //status.text = err.localizedFailureReason
            
            NSLog("%@", err.localizedFailureReason!)
            
        } else {
            NSLog("Item inserted successfuly...")
            //            name.text = ""
            //            address.text = ""
            //            phone.text = ""
            //            status.text = "Contact Saved"
        }
        
    }
    
    func RetrieveItems() ->[Item]{
        
        //make instances
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //Instance manage object
        let managedContext = appDelegate.managedObjectContext
        
        //Cacth error
        var error: NSError?
        
        //Get elements from Item entity
        let fetchRequest = NSFetchRequest(entityName: "Items")
        let fetchResults: [AnyObject]?
        do {
            fetchResults = try managedContext.executeFetchRequest(fetchRequest)
        } catch let error1 as NSError {
            error = error1
            fetchResults = nil
        }
        
        
        var ItemsArray = [Item]()
        
        //Fetch elements from
        if fetchResults!.count > 0 {
            
            for result: AnyObject in fetchResults! {
                
                let ItemReload = Item()
                
                //Get values from entity
                let id = result.valueForKey("id") as! Int
                let name = result.valueForKey("name") as! String
                let descriptionItem = result.valueForKey("descriptionItem") as! String
                let image = result.valueForKey("image") as! NSData
                let price = result.valueForKey("price") as! Float
                let goalLike = result.valueForKey("goalLike") as! Int
                let amountScans = result.valueForKey("amountScans") as! Int
                
                
                
                //Set Values in class Item
                ItemReload.id = id
                ItemReload.name = name
                ItemReload.descriptionItem = descriptionItem
                ItemReload.image = image
                ItemReload.price = price
                ItemReload.goalLike = goalLike
                ItemReload.amountScans = amountScans
                
                //                println(id)
                //                println(name)
                //                println(descriptionItem)
                //                println(price)
                //                println(goalLike)
                //                println(amountScans)
                
                ItemsArray.append(ItemReload)
                
            }
            print("Finish")
            
            return ItemsArray
        }
        else {
            print("No data")
            return ItemsArray
        }
        //return ItemsArray
    }
    
    func RetrieveItemsFromSales() ->[Int]{
        
        //make instances
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //Instance manage object
        let managedContext = appDelegate.managedObjectContext
        
        //Cacth error
        var error: NSError?
        
        //Get elements from Item entity
        let fetchRequest = NSFetchRequest(entityName: "Sale")
        let fetchResults: [AnyObject]?
        do {
            fetchResults = try managedContext.executeFetchRequest(fetchRequest)
        } catch let error1 as NSError {
            error = error1
            fetchResults = nil
        }
        
        
        var ItemsArray = [Int]()
        
        //Fetch elements from
        if fetchResults!.count > 0 {
            
            for result: AnyObject in fetchResults! {
                
                _ = Item()
                
                //Get values from entity
                let id = result.valueForKey("id") as! Int
                
                ItemsArray.append(id)
                
            }
            print("Finish")
            
            return ItemsArray
        }
        else {
            print("No data")
            return ItemsArray
        }
        //return ItemsArray
    }
    
    func InsertItemSales(id:Int, quantity:Int) {
        //make instances
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //Instance manage object
        let managedContext = appDelegate.managedObjectContext
        
        //Instance object Item
        let entity =  NSEntityDescription.entityForName("Sale",inManagedObjectContext:managedContext)
        
        let Item = NSManagedObject(entity: entity!,insertIntoManagedObjectContext: managedContext)
        
        //Set data in repository
        Item.setValue(id, forKey: "id")
        Item.setValue(quantity, forKey: "quantity")
        
        var error: NSError?
        do {
            //Save Item
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            
            NSLog("%@", err.localizedFailureReason!)
            
        } else {
            NSLog("Item inserted sales successfuly...")
        }
        
    }
}