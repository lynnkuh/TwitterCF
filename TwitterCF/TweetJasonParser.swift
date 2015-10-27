//
//  TweetJasonParser.swift
//  TwitterCF
//
//  Created by Regular User on 10/26/15.
//  Copyright © 2015 Lynn Kuhlman. All rights reserved.
//

import Foundation

class TweetJSONParser {
    
    class func tweetFromJSONData(json: NSData) -> [Tweet]? {
        
        var tweets = [Tweet]()
        
        do {
            
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.MutableContainers) as? [[String : AnyObject]] {
                
                print(rootObject)
                
                for tweetObject in rootObject {
                    if let user = tweetObject["user"] as? [String:AnyObject],
                        name = user["name"] as? String ,
                        text = tweetObject["text"] as? String,
                        id = tweetObject["id_str"] as? String,
                        profileImageURL = user["profile_image_url"] as? String {
                            let tweet = Tweet(text: text, id: id, username: name, profileImageURL: profileImageURL)
                            tweets.append(tweet)
                        }
                        
                    }
                }
                return tweets
        } catch _ {
            return nil
        }
        
    }
    
    
}

