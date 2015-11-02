//
//  CustomTweetTableViewCell.swift
//  TwitterCF
//
//  Created by Regular User on 11/1/15.
//  Copyright © 2015 Lynn Kuhlman. All rights reserved.
//

import UIKit

class CustomTweetTableViewCell: UITableViewCell {

        
    @IBOutlet weak var imgView: UIImageView!
        
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
        
    var tweet: Tweet? {
        
        
        didSet {
            
            if let tweet = self.tweet,
                user = tweet.user,
                text = self.tweet?.text {
                    
                    self.tweetTextLabel.text = text
                    
                    if let image = user.image {
                        self.imgView.image = image
                    }
                    else {
                        if let url = NSURL(string: user.profileImageURL) {
                            let downloadQ = dispatch_queue_create("downloadQ", nil)
                            dispatch_async(downloadQ, { () -> Void in
                                let imageData = NSData(contentsOfURL: url)!
                                
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    let image = UIImage(data: imageData)
                                    self.imgView.image = image
                                    user.image = image
                                })
                            })
                        }
                    }
                    
            }
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
