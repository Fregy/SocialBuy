//
//  ViewController.swift
//  MyFinalProject
//
//  Created by MCS on 11/10/15.
//  Copyright © 2015 MCS. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SocialBuy_WelcomeView: UIViewController,CLLocationManagerDelegate {
    
    //@IBOutlet var myMap: MKMapView!
    let locationManager = CLLocationManager()
    var timer       = NSTimer()
    var binaryCount = 0b0000
    var wasGood = false
    var postCode:String = ""


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        timer = NSTimer(timeInterval: 1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    //CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil)
            {
                self.timer.invalidate()

                print("Error: " + error!.localizedDescription)
                let refreshAlert = UIAlertController(title: "Error", message: "We couldn't get your current location", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    exit(0)
                }))
                
                self.presentViewController(refreshAlert, animated: true, completion: nil)
                return
            }
            
            if placemarks!.count > 0
            {

                let pm = placemarks?[0]
                self.wasGood = true
                self.displayLocationInfo(pm!)
                
                
                
            }
            else
            {
                self.timer.invalidate()

                print("Error with the data.")
            }
        })
    }
    func displayLocationInfo(placemark: CLPlacemark){
        self.locationManager.stopUpdatingLocation()
        
        self.postCode = placemark.postalCode!
        print(placemark.locality)
        print(placemark.postalCode)
        print(placemark.administrativeArea)
        print(placemark.country)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.timer.invalidate()
        print("Errors: " + error.localizedDescription)
        let refreshAlert = UIAlertController(title: "Error", message: "We couldn't get your current location", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            exit(0)
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    //Timer Method
    func countUp() {
        
        binaryCount += 0b0001
        //print(binaryCount)
    // if the counter reached 16, reset it to 0
       // if (binaryCount == 0b10011) { 20
        if (binaryCount == 0b00011) {
            
            binaryCount = 0b0000
            timer.invalidate()
            if(wasGood == true){
                
                let seconScene = self.storyboard?.instantiateViewControllerWithIdentifier("seconScene") as! SocialBuy_StoresView
                
                self.navigationController?.pushViewController(seconScene, animated: true)
                seconScene.postCode = self.postCode
                //            seconScene.postCode = "30339"
                
            }
            

        }
    }
}
