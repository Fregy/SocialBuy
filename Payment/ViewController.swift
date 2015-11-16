//
//  ViewController.swift
//  FinalProjectV1
//
//  Created by MCS on 11/10/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

import UIKit
//import DataBase

//class ViewController: UIViewController {
class ViewController: UIViewController{
    //class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var objects = [String]()
    var Descriptions = [String]()
    var itemPrices = [Float]()
    var logoImage = [UIImage] ()
    var socialNetwork: Bool = true
    var Sales = [Int]()
    
    var coreData: DataBase! = DataBase()
    var ItemsArray = [Item]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Set title from App
        self.title = "Clearances"
       
        
        //Get previous purchase
        self.Sales = coreData.RetrieveItemsFromSales()
        
        
        if self.Sales.count > 0{
            
            //self.ItemsArray = coreData.RetrieveItemsWithOutSales(self.Sales)
            self.ItemsArray = coreData.RetrieveItems()
            
            //Make a mix of sales and Stock
            MixSales()

            print(self.ItemsArray, terminator: "" )
        }else{
            //Get previous purchase
            self.ItemsArray = coreData.RetrieveItems()
      
            //If doesn't have information in CoreData reload dad
            if self.ItemsArray.count == 0{
        
                //Get all elements
                self.getDefaultData()
            
            //Insert Elements in database
                insertItemsDatabase()

            }else{
                //Get Items from CoreData
                getArrayOfData()

            }
        }
        
        //Mode Testing
        //socialNetwork = false
        
        //Show or hide tabs depends kind of loggin
        if (socialNetwork == true){
            self.tabBarController?.tabBar.hidden = false
        }else{
            self.tabBarController?.tabBar.hidden = true
        }
        
    }
    
    
    //Get all elements
    func getArrayOfData(){
        
        //self.ItemsArray
        
        for Item in self.ItemsArray {
            
            let name            = Item.name
            let descriptionItem = Item.descriptionItem
            _                   = Item.id
            let image           = Item.image
            let price           = Item.price
            _                   = Item.goalLike
            _                   = Item.amountScans
            
            let imageItem = UIImage(data:image!,scale:1.0)
            
            //fill name's Array
            self.objects.append(name!)
            self.Descriptions.append(descriptionItem!)
            self.itemPrices.append(price!)
            self.logoImage.append(imageItem!)
        }
        
    }

    
    
    //Get all elements and Mix with Sales
    func MixSales(){
        
        //Elements sales
        for Item in self.ItemsArray {
            
            let name            = Item.name
            let descriptionItem = Item.descriptionItem
            let id              = Item.id
            let image           = Item.image
            let price           = Item.price
            _                   = Item.goalLike
            _                   = Item.amountScans
            let imageItem = UIImage(data:image!,scale:1.0)
            
            
            //Verifie if id exist in sales
            for idSales: AnyObject in self.Sales{
                if (idSales as! Int) == id{
                    
                    //fill name's Array
                    self.objects.append(name!)
                    self.Descriptions.append(descriptionItem!)
                    self.itemPrices.append(price!)
                    self.logoImage.append(imageItem!)
                    break
                }
            }
        }
        
        //Get data with out Sales
        self.ItemsArray = coreData.RetrieveItemsWithOutSales(self.Sales)
        
        //Elements in stock
        for Item in self.ItemsArray {
            
            let name            = Item.name
            let descriptionItem = Item.descriptionItem
            _                   = Item.id
            let image           = Item.image
            let price           = Item.price
            _                   = Item.goalLike
            _                   = Item.amountScans
            let imageItem = UIImage(data:image!,scale:1.0)
            
            //fill name's Array
            self.objects.append(name!)
            self.Descriptions.append(descriptionItem!)
            self.itemPrices.append(price!)
            self.logoImage.append(imageItem!)


        }
        
    }
    
    //Insert Items
    func insertItemsDatabase(){
    
        for ( var i=0; i<self.objects.count; i++){
            
            //Set values from arrays
            let nameItem        = self.objects[i]
            let descriptionItem = self.Descriptions[i]
            let priceItem       = self.itemPrices[i]
            let imageItem       = self.logoImage[i]
            
            
            //Insert elements in database
            coreData.InsertItem(i, name: nameItem, descriptionItem: descriptionItem, image: imageItem, price: priceItem)
        }
        
    }
    
    //Get all elements
    func getDefaultData()
    {
        
        //Array of Titles
        self.objects.append("Samsung Galaxy S5")
        self.objects.append("Kleenex Cottonelle")
        self.objects.append("Canon PowerShot N 12.1")
        self.objects.append("Dove Men")
        self.objects.append("Guess Eau ")
        self.objects.append("Gillette Mach3")
        self.objects.append("Colgate Total")
        self.objects.append("Oral-B")
        self.objects.append("TCL 40FS3800")
        self.objects.append("Puffer Jacket")
        self.objects.append("Apple iPad mini")
        
        //Arrays of images
        self.logoImage.append(UIImage(named: "samsung")!)
        self.logoImage.append(UIImage(named: "cotonelle")!)
        self.logoImage.append(UIImage(named: "camara")!)
        self.logoImage.append(UIImage(named: "dove")!)
        self.logoImage.append(UIImage(named: "parfum")!)
        self.logoImage.append(UIImage(named: "gillete")!)
        self.logoImage.append(UIImage(named: "colgate")!)
        self.logoImage.append(UIImage(named: "oralb")!)
        self.logoImage.append(UIImage(named: "tv")!)
        self.logoImage.append(UIImage(named: "jacket")!)
        self.logoImage.append(UIImage(named: "ipadmini")!)
      
        //Array of Description
        self.Descriptions.append("Kleenex Cottonelle Ultrasoft Bulk Toilet Paper (12456), Standard Toilet Paper Rolls, 48 Rolls / Case (4 Packs of 12)")
        self.Descriptions.append("Samsung Galaxy S5 G900F Unlocked Cellphone, International Version, Retail Packaging, White")
        self.Descriptions.append("Canon PowerShot N 12.1 MP CMOS Digital Camera with 8x Optical Zoom and 28mm Wide-Angle Lens (White)")
        self.Descriptions.append("Dove Men+Care Antiperspirant & Deodorant, Extra Fresh 2.7 oz, Twin Pack")
        self.Descriptions.append("Guess Eau de Parfum Spray for Women, 2.5 Fluid Ounce")
        self.Descriptions.append("Gillette Mach3 Base Cartridges 15 Count from Gillette")
        self.Descriptions.append("Colgate Total Whitening Toothpaste Twin Pack (two 6oz tubes)")
        self.Descriptions.append("Oral-B Pro-Health Clinical Pro-Flex Medium Toothbrush, 2 Count, (Colors May Vary)")
        self.Descriptions.append("TCL 40FS3800 40-Inch 1080p Roku Smart LED TV (2015 Model)")
        self.Descriptions.append("Free Country Little Boys' Systems Coat with Puffer Jacket")
        self.Descriptions.append("Apple iPad mini FD531LL/A 16GB, Wi-Fi, (White/Silver) (Certified Refurbished)")
        
        
        
        //Array of prices
        self.itemPrices.append(369.94)
        self.itemPrices.append(32.89)
        self.itemPrices.append(124.99)
        self.itemPrices.append(44.14)
        self.itemPrices.append(32.89)
        self.itemPrices.append(34.54)
        self.itemPrices.append(7.54)
        self.itemPrices.append(32.89)
        self.itemPrices.append(279.99)
        self.itemPrices.append(97.89)
        self.itemPrices.append(219.00)

    
    
    }
    
    func getElementsPurchase(){
    
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
        let aCell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
       
        //Set values from arrays
        aCell.titleItem.text = self.objects[indexPath.row]
        aCell.descriptionItem.text = self.Descriptions[indexPath.row]
        aCell.priceITem.text = "$"+String(stringInterpolationSegment: self.itemPrices[indexPath.row])
        aCell.imageItem.image = self.logoImage[indexPath.row]
        
        //Circle images
        aCell.imageItem.layer.cornerRadius = aCell.imageItem.bounds.height / 2
        aCell.imageItem.clipsToBounds = true
        
        //Border in images
        aCell.imageItem.layer.borderWidth = 1
        aCell.imageItem.layer.borderColor = UIColor.grayColor().CGColor
        
        return aCell
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "CellSend")
        {
            
            let indexPath = self.tableView.indexPathForSelectedRow!

            //var detailItems: DetailClarenceViewController =
            let detailItems = segue.destinationViewController as? DetailClarenceViewController
            
            //Get string of title
            let titleString = self.objects[indexPath.row]
          
            //Detail of elements
            detailItems!.titleItemSend = titleString
            detailItems!.imageItemSend = self.logoImage[indexPath.row]
            detailItems!.descriptionItemSend = self.Descriptions[indexPath.row]
            detailItems!.itemPriceSend = " Price: $"+String(stringInterpolationSegment: self.itemPrices[indexPath.row])
            
            //
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }else if (segue.identifier == ""){
        
        //Here is action to use the camera
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}