//
//  ViewController.swift
//  TwitterCF
//
//  Created by Regular User on 10/26/15.
//  Copyright © 2015 Lynn Kuhlman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    
    class func identifier() -> String {
        return "HomeViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
//       self.setupCustomTwitterCell()
        self.getAccount()
        self.getTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let customTwitterCellXib = UINib(nibName: "TwitterCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(customTwitterCellXib, forCellReuseIdentifier: CustomTweetTableViewCell.identifier())
 /*
      let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
       spinner.hidesWhenStopped = true
        spinner.startAnimating()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
*/
    }
/*
    func setupCustomTwitterCell() {
        
        let customTwitterCellXib = UINib(nibName: "TwitterCell", bundle: NSBundle.mainBundle())
            self.tableView.registerNib(customTwitterCellXib, forCellReuseIdentifier: CustomTweetTableViewCell.identifier())
    }

*/
    func updateFeed(sender: AnyObject) {
        //Simulate network call
        
        NSOperationQueue().addOperationWithBlock { () -> Void in
            if let spinner = sender as? UIRefreshControl {
                spinner.endRefreshing()
            }
        }
        
    }
    
    func getAccount() {
        LoginService.loginTwitter({ (error, account) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let account = account {
                TwitterService.sharedService.account = account
                self.authenticateUser()
            }
        })
    }
    
    func authenticateUser(){
        TwitterService.getAuthUser { (error, user) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let user = user {
                TwitterService.sharedService.user = user
                self.getTweets()
            }
        }
    }
    
    func getTweets() {
        print("get tweets fired")
        TwitterService.tweetsFromHomeTimeline { (error, tweets) -> () in
            print(error)
            print(tweets)
            if let error = error {
                print(error)
                return
            }
            
            if let tweets = tweets {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweets = tweets
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("segue fired!")
        if segue.identifier == "showTweetDetail" {
            
            
            if let twitterDetailViewController = segue.destinationViewController as? DetailViewController {
                
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    let selectedRow = selectedIndexPath.row

                    let chosenTweet = tweets[selectedRow]
                    
                    twitterDetailViewController.tweet = chosenTweet
                    
                }
            }
        } else if segue.identifier == "MyOtherSegue" {
            //this code would customize based on going to a different view controller
        }
        
    }
    
    //MARK: UITableView 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomTweetTableViewCell = tableView.dequeueReusableCellWithIdentifier(CustomTweetTableViewCell.identifier(), forIndexPath: indexPath)
            as! CustomTweetTableViewCell
        
        
        cell.tweet = tweets[indexPath.row]
        
 //      let tweet = self.tweets[indexPath.row]
        
//       cell.textLabel?.numberOfLines = 0
 //      cell.textLabel?.text = tweet.text
//       cell.imgView?.image = tweet.user?.image
 //     if let user = tweet.user {
 //          cell.detailTextLabel?.text = "Posted by: \(user.name)"
 //      } else {
 //           cell.detailTextLabel?.text = "Posted by: Sponsor."
 //       }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showTweetDetail", sender: nil)
    }


}

