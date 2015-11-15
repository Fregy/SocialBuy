//
//  SocialNetwork.swift
//  FinalProjectV1
//
//  Created by MCS on 11/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

    import UIKit
    import Social
    import Accounts
    import Twitter
    

    class SocialNetwork: UIViewController {
   
        //Outles
        @IBOutlet var tableView: UITableView!
        @IBOutlet var imageTw  : UIImageView!
        
        //Declare variables
        var dataSource      = [AnyObject]()
        var dataSourceTwits = NSDictionary()
        var hashtagTwits    = NSMutableArray()
        
        var refreshControl = UIRefreshControl()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Assign identifier of the cell
            self.tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
            
            //Add refresh Control
            self.refreshControl.attributedTitle = NSAttributedString(string: "Loading")
            self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
            self.tableView.addSubview(refreshControl)
            
          
                        
        }
        //Refresh Control
        func refresh(sender:AnyObject)
        {
            
            //Reload  Information
            self.getTimeLine()
            
            //End Control
            self.refreshControl.endRefreshing()
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //return dataSource.count
            let row = hashtagTwits.count
            
            return hashtagTwits.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

            
            let aCell = self.tableView.dequeueReusableCellWithIdentifier("CellNetwork", forIndexPath: indexPath) as! cellSocialNetwork
            
            //Get the current row
            let row = indexPath.row
            //Get twits
            let tweet = self.hashtagTwits[row]
           
            //Declare Variables
            var HashtagTw         = NSDictionary()
            var userHashtagTwData = NSDictionary()

            //Data from hastag
            HashtagTw = self.hashtagTwits[row] as! NSDictionary
            //Data from User
            userHashtagTwData = HashtagTw["user"] as! NSDictionary
            //Get Image from User
            let imageHashtagTwData = userHashtagTwData["profile_image_url"] as! String
            
            let userTwitter = userHashtagTwData["name"] as! String
            
            //Set image to imageView
            let userImage =  UIImage(data: NSData(contentsOfURL: NSURL(string:imageHashtagTwData)!)!)
            //user Image
            //self.imageTw.image = userImage
            
            
//            let object = self.tweet.objectAtIndexPath(indexPath) as NSManagedObject
//
//            var attrString: NSMutableAttributedString = NSMutableAttributedString(string: object.valueForKey("example1")!.description)
//            
//            
//            attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, attrString.length))
//            
//            var descString: NSMutableAttributedString = NSMutableAttributedString(string:  String(format: "    %@", object.valueForKey("example2")!.description))
//            
//            descString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, descString.length))
//            
//            attrString.appendAttributedString(descString);
//            cell.textLabel?.attributedText = attrString
            
            
            let main_string = "Hello World"
            let string_to_color = "World"
            
            let range = (main_string as NSString).rangeOfString(string_to_color)
            
            let attributedString = NSMutableAttributedString(string:main_string)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor() , range: range)
            
            //aCell.post = attributedString
            
            aCell.post.text = tweet.objectForKey("text") as? String
            aCell.post!.numberOfLines = 0
            
            
            
            
            aCell.namePoster.text = userTwitter
            aCell.imageNetwork.image = userImage
            
            //Circle images
            aCell.imageNetwork.layer.cornerRadius = aCell.imageNetwork.bounds.height / 4
            aCell.imageNetwork.clipsToBounds = true
            
//            //Border in images
//            aCell.imageNetwork.layer.borderWidth = 1
//            aCell.imageNetwork.layer.borderColor = UIColor.grayColor().CGColor
            
            return aCell

        }
        override func viewWillAppear(animated: Bool) {
            //Get twits
            self.getTimeLine()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        func getTimeLine() {
            
            let account = ACAccountStore()
            let accountType = account.accountTypeWithAccountTypeIdentifier(
                ACAccountTypeIdentifierTwitter)
            
            account.requestAccessToAccountsWithType(accountType, options: nil, completion: {(success: Bool, error: NSError!) -> Void in
                
                if success
                {
                    let arrayOfAccounts = account.accountsWithAccountType(accountType)
                    
                    if arrayOfAccounts.count > 0
                    {
                        let twitterAccount = arrayOfAccounts.last as! ACAccount
                        //Get URL to request twits
                        let requestURL = NSURL(string:"https://api.twitter.com/1.1/search/tweets.json")
       
                        //Make parameters
                        let parameters = [
                            "q" : "%23SocialBuy"
                        ]
                        //Make data to request
                        let postRequest = SLRequest(forServiceType: SLServiceTypeTwitter,
                            requestMethod: SLRequestMethod.GET,
                            URL: requestURL,
                            parameters: parameters )
                        //Make request
                        postRequest.account = twitterAccount
                        
                        postRequest.performRequestWithHandler({(responseData: NSData!,
                            urlResponse: NSHTTPURLResponse!,
                            error: NSError!) -> Void in
                            var err: NSError?
                            
                            self.dataSourceTwits = (try! NSJSONSerialization.JSONObjectWithData(responseData,options: NSJSONReadingOptions.MutableLeaves)) as! NSDictionary
                            
                            if self.dataSourceTwits.count != 0
                            {
                                dispatch_async(dispatch_get_main_queue())
                                {
                                    //Declare Variables
                                    var HashtagTw         = NSDictionary()
                                    var userHashtagTwData = NSDictionary()
                                    //Get values from dictionary
                                    self.hashtagTwits = self.dataSourceTwits["statuses"] as! NSMutableArray
             
                                    self.tableView.reloadData()
                                }
                            }
                        })
                    }
                } else {
                    print("Failed to access account")
                }
            })
        }
     
}

