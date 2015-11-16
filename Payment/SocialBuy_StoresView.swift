//
//  SocialBuy_StoresView.swift
//  MyFinalProject
//
//  Created by MCS on 11/10/15.
//  Copyright © 2015 MCS. All rights reserved.
//


import UIKit

class SocialBuy_StoresView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var storesCollectionView: UICollectionView!
    var myDictionary = NSMutableDictionary()
    var myDictionaryTwo = NSArray()
    var myDictionaryKeys = NSArray()
    var postCode = NSString()
    var storesAround = NSMutableArray()
    var stringImageToShow = NSString()
    var imagesArray = NSMutableArray()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        storesCollectionView.dataSource = self
        //print(postCode)
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let jsonClass = JSONParser()
        jsonClass.jsonParsingFromFile()
        //var counter = 0
        self.myDictionary = jsonClass.myDicc.objectAtIndex(0) as! NSMutableDictionary
//       // print(myDictionary)
//        return myDictionary.count
        //return 5
        
        myDictionaryTwo = myDictionary.allValues
        myDictionaryKeys = myDictionary.allKeys
        
        for(var i = 0; i < myDictionaryKeys.count ; i++){
        let tempArray = myDictionary.valueForKey(myDictionaryKeys.objectAtIndex(i) as! String)
        
        let tempArrayEachStore = tempArray?.objectForKey("Address")
        let tempPostCode = tempArrayEachStore?.objectForKey("PostCode") as! String

        
            if(tempPostCode == self.postCode){
               // counter = counter + 1
                storesAround.addObject(tempArray!)
                

                //storesAround.setObject((tempArray?.objectAtIndex(0))!, forKey: i)
            }
        }
        return storesAround.count
        
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let jsonClass = JSONParser()
       
        jsonClass.jsonParsingFromFile()
        
        let identifier = "Cell"
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! StoreCell

        
        let tempArray = storesAround.objectAtIndex(indexPath.row)
        let tempString = tempArray.objectForKey("Picture")as! String
        
        imagesArray.addObject(tempString)
        cell.imageViewCell.image = UIImage(named: tempString)
       // print(tempArray)
        
    
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //print(indexPath.row)
        
        let sceneLoggin = self.storyboard?.instantiateViewControllerWithIdentifier("LogginScene") as! Social_BuyLoggin
        
        self.navigationController?.pushViewController(sceneLoggin, animated: true)
        let tempStringImage = imagesArray.objectAtIndex(indexPath.row)
        
        sceneLoggin.imageFromSegue = tempStringImage as! NSString

    }
}