//
//  DetailViewController.swift
//  TwitterCF
//
//  Created by Regular User on 10/29/15.
//  Copyright © 2015 Lynn Kuhlman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

        var tweet: Tweet!
    
    @IBOutlet weak var tweetPostLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.setupAppearance()
            self.setupTweetDetailViewController()
//            tweetTextLabel.text = selectedTweet.text
//            tweetPostLabel.text = selectedTweet.user!.name
            
            
            // Do any additional setup after loading the view.
        }
    
    func setupAppearance() {
        if self.tweet.isRetweet {
            if let reqUser = self.tweet.reqUser {
                self.navigationItem.title = reqUser.name
                self.tweetPostLabel.text = reqUser.name
            } else {
                self.navigationItem.title = self.tweet.user?.name
                self.tweetPostLabel.text = self.tweet.user?.name
            }
        }
        
        if let user = self.tweet.user {
            self.navigationItem.title = user.name
            self.tweetPostLabel.text = user.name
        }
    }
    
    func setupTweetDetailViewController() {
        self.tweetTextLabel.text = self.tweet.isRetweet ? self.tweet.reqText : self.tweet.text
    }
    

}
