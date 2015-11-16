//
//  ScansCenter.swift
//  FinalProjectV1
//
//  Created by MCS on 11/15/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

import UIKit

class ScansCenter: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var discounts = [Int]()
    var objects = [String]()
    var Descriptions = [String]()
    var itemPrices = [Float]()
    var logoImage = [UIImage] ()
    
    var coreData:DataBase!
    var ItemsArray = [Item]()
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Set title from App
        self.title = "Scan picked up"
        
        //Add refresh Control
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
//        //Get previous purchase
//        self.ItemsArray = coreData.RetrieveItems()
//        
//        if self.ItemsArray.count > 0{
//            //Set data from CoreData to Show
//            setArrayOfData()
//        }
    }
    
    //Refresh Control
    func refresh(sender:AnyObject)
    {
        //Remove all elements previo to load
        self.ItemsArray.removeAll()
        
        //Get previous purchase
        self.ItemsArray = coreData.RetrieveItems()
        
        if self.ItemsArray.count > 0{
            //Set data from CoreData to Show
            setArrayOfData()
            
            //End Control
            self.refreshControl.endRefreshing()
        }

    }

    
    override func viewWillAppear(animated: Bool) {
        //Get previous purchase
        self.ItemsArray = coreData.RetrieveItems()
        
        if self.ItemsArray.count > 0{
            //Set data from CoreData to Show
            setArrayOfData()
        }
    }
  
    //Get all elements
    func setArrayOfData(){
        
        var numberOfScansDone = 0
        
        for Item in self.ItemsArray {
            
            let name            = Item.name
            let descriptionItem = Item.descriptionItem
            var id              = Item.id
            let image           = Item.image
            let price           = Item.price
            let goalLike        = Item.goalLike
            let amountScans     = Item.amountScans
            let imageItem = UIImage(data:image!,scale:1.0)
            
            
            
            if goalLike > 0{
                
                //fill name's Array
                self.objects.append(name!)
                self.Descriptions.append(descriptionItem!)
                self.itemPrices.append(price!)
                self.logoImage.append(imageItem!)
                
                //If Goal complets Show de badge
                if goalLike == amountScans{
                    
                    self.discounts.append(1)
                    //Get numbers of Scans Done
                    numberOfScansDone++
            
                }else{
                    self.discounts.append(0)
                }
            }
          
        }
     
        //Set numbers of scans Done
        if numberOfScansDone > 0{
            // for last tab
            (tabBarController!.tabBar.items!.last! ).badgeValue =  String(numberOfScansDone)
        }
    }
     
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.objects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let aCell = self.tableView.dequeueReusableCellWithIdentifier("CellScans", forIndexPath: indexPath) as! ScansCell
        
        //Set values from arrays
        aCell.nameScans.text = self.objects[indexPath.row]
        aCell.detailScans.text = self.Descriptions[indexPath.row]
        aCell.imageScans.image = self.logoImage[indexPath.row]
        
        
        let discount = self.discounts[indexPath.row]
        
        if discount==1{
            aCell.statusScans.text = "Discount Available"
        }
        else{
            aCell.statusScans.text = ""
        }
        
        //Circle images
        aCell.imageScans.layer.cornerRadius = aCell.imageScans.bounds.height / 2
        aCell.imageScans.clipsToBounds = true
        
        //Border in images
        aCell.imageScans.layer.borderWidth = 1
        aCell.imageScans.layer.borderColor = UIColor.grayColor().CGColor
        
        return aCell
    }
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
