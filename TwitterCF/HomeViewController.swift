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
        self.getTweets()
        self.traverseArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func getTweets() {
        
        if let tweetJSONFileUrl = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") {
            
            print(tweetJSONFileUrl)
            
            if let tweetJSONData = NSData(contentsOfURL: tweetJSONFileUrl) {
                
                print(tweetJSONData)
                
                
                if let tweets = TweetJSONParser.tweetFromJSONData(tweetJSONData) {
                    
                    print(tweets)
                    
                    self.tweets = tweets
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }
    
    func traverseArray() {
        
        for var i = tweets.count; i <= 1; i-- {
//           print("\(tweets[i])")
             print("\(i)")
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
        cell.detailTextLabel?.text = "Tweet id is: \(tweet.id)"
        
        
        return cell
    }


}

