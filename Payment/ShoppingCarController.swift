//
//  ShoppingCarController.swift
//  Social Buy
//
//  Created by MCS on 11/10/15.
//  Copyright © 2015 Mobile Consulting Solutions. All rights reserved.
//

import UIKit

protocol ShoppingCarControllerDelegate
{
    func didFindDuplicates(product:Product)
}

class ShoppingCarController: UITableViewController,PurchaseProductCellDelegate,ScannerDelegate  {
    
    private var delegate : ShoppingCarControllerDelegate!
    private var ProductsList = [Product]()
    private var product = Product()
    private var cuponAlertController = UIAlertController()
    
    @IBOutlet var editButton: UIButton!
    
    @IBOutlet var totalPurchase: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAlertViewControllers()
        //createItems()
        navigationController?.toolbarHidden = false
        navigationController?.toolbar.translucent = true
        
    }
    
    func didScanProduct(item: Product) {
//        
//        if item.discount == true
//        {
//
//        }
//        else
//        {
            print("Adding: \(item.name)")
            ProductsList.append(item)
            reloadList()
//        }
        
    }
    
    func didChangeQty(qty: Int, ofProduct: Int ) {
        
        for prod in ProductsList
        {
            if prod.id == ofProduct && prod.discount == false
            {
                prod.quantity = qty
            }
        }
        countTotal()
        tableView.reloadData()
    }
    
    func createAlertViewControllers()
    {
        cuponAlertController = UIAlertController(title: "Cupon", message: "Number Of Cupon", preferredStyle: .Alert)
        
        let addProduct = UIAlertAction(title: "Submit", style: .Default) {(_) in
            let loginTextField = self.cuponAlertController.textFields![0] as UITextField
            
            self.checkForCupon(loginTextField.text!)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Default) {(_) in
            
        }
        
        cuponAlertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Cupon Number"
            textField.secureTextEntry = false
            
            let myButton = UIButton()
            myButton.frame = CGRectMake(textField.bounds.size.width - 10, textField.bounds.size.height, 19, 18)
            myButton.setImage(UIImage(named: "camera"), forState: .Normal)
            myButton.addTarget(self, action: Selector("scanItem"), forControlEvents: .TouchUpInside)
            
            textField.rightViewMode = .WhileEditing
            textField.rightView = myButton
            
        }
        
        cuponAlertController.addAction(addProduct)
        cuponAlertController.addAction(cancel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProductsList.count
    }
    @IBAction func editProductList(sender: UIButton) {
        
        if tableView.editing == true
        {
            editButton.setTitle("Edit", forState: .Selected)
            editButton.selected = false
            tableView.editing = false
        }
        else
        {
            editButton.setTitle("Done", forState: .Selected)
            editButton.selected = true
            tableView.editing = true
        }
        
    }
    
    func countTotal()
    {
        var total = Double()
        for prod in ProductsList
        {
            total = total + (prod.price * Double(prod.quantity))
        }
        
        totalPurchase.title = String(total)
    }
    
    
    @IBAction func addProduct(sender: UIButton) {
        
        //self.addProductToList(self.product)
        scanItem()
        reloadList()
    }
    
    func addProductToList(newPurchase : Product)
    {
        if self.findingDuplicates(newPurchase) == false
        {
            ProductsList.append(newPurchase)
            reloadList()
        }
    }
    
    @IBAction func cuponButtonTapped(sender: UIBarButtonItem) {
        addCupon("")
    }
    func addCupon(cupon :String)
    {
        self.presentViewController(self.cuponAlertController, animated: true){}
    }
    
    func checkForProduct()
    {
        print("ScanProduct : Product")
    }
    
    func checkForCupon(cupon:String)
    {
        print("ScanCupon: Code")
    }
    
    func scanItem()
    {
        print("Scan Item")
        let scannerStoryboard : UIStoryboard = UIStoryboard(name: "Scanner", bundle: nil)
        
        let Scanner : ScannerViewController = scannerStoryboard.instantiateViewControllerWithIdentifier("Scanner") as! ScannerViewController
        
        Scanner.delegate = self
        
        self.presentViewController(Scanner, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let currentProduct:Product = ProductsList[indexPath.row]
        
        if currentProduct.discount == true
        {
            return 52
        }
        else
        {
            return 135
        }
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let currentProduct:Product = ProductsList[indexPath.row]
        
        let cellout = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        if currentProduct.discount  == false
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as!
            PurchaseProductCell
            
            cell.nameItem.text   = currentProduct.name
            cell.descItem.text   = currentProduct.desc
            cell.priceItem.text  = String(format: "%.2f", currentProduct.price) as String
            cell.qtyItem.text    = String(currentProduct.quantity)
            cell.productId = currentProduct.id
            
            cell.subtotalItem.text = String(Double(currentProduct.quantity) * currentProduct.price)
            cell.frame.size = CGSizeMake(cell.bounds.width,135)
            cell.imageItem.image = UIImage(named:"item" + String(currentProduct.id))
            cell.delegate = self
            return cell
        }
        else if currentProduct.discount
        {
            let cell:CuponCell = tableView.dequeueReusableCellWithIdentifier("cuponCell", forIndexPath: indexPath) as!
            CuponCell

            cell.cuponId.text = String(currentProduct.id)
            cell.cuponDescription.text = currentProduct.desc
            cell.cuponValue.text = String(currentProduct.price)
            cell.cuponValue.textColor = UIColor .redColor()
            cell.frame.size = CGSizeMake(cell.bounds.width,52)
            
            
            
            return cell
        }
        
        return cellout
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            ProductsList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func reloadList()
    {
        countTotal()
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "paymentSegue"
        {
            let paymentVC : NavigationPayment = segue.destinationViewController as! NavigationPayment
            
            paymentVC.myArrayItems = self.ProductsList
        }
        
    }
    
    func findingDuplicates(object : Product) -> Bool
    {
        for item in ProductsList
        {
            if item.id == object.id
            {
                self.delegate .didFindDuplicates(object)
                return true
            }
        }
        return false
    }
    
    func createItems()
    {
        let product:Product  = Product()
        
        product.id = 1
        product.name = "Water"
        product.desc = "peña pura"
        product.price = 10.0
        product.discount = false
        product.quantity = 1
        
        let cupon:Product = Product()
        
        cupon.id = 10
        cupon.name = "cupon for water"
        cupon.desc = "cupon for water"
        cupon.price = -2
        cupon.discount = true
        cupon.quantity = 1
        
        
        self.ProductsList.append(product)
        self.ProductsList.append(cupon)
        
    }
    
}
