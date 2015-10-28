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
        self.getAccount()
        self.getTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
    
    
    
    //MARK: UITableView 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath)
        
        let tweet = self.tweets[indexPath.row]
        
        cell.textLabel?.text = tweet.text
        if let user = tweet.user {
            cell.detailTextLabel?.text = "Posted by: \(user.name)"
        } else {
            cell.detailTextLabel?.text = "Posted by: Sponsor."
        }
        
        
        return cell
    }


}

