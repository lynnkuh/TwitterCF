//
//  TweetJasonParser.swift
//  TwitterCF
//
//  Created by Regular User on 10/26/15.
//  Copyright © 2015 Lynn Kuhlman. All rights reserved.
//

import Foundation

class TweetJSONParser {
    
    class func TweetFromJSONData(json: NSData) -> [Tweet]? {
        
        var tweets = [Tweet]()
        
        do {
            
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.MutableContainers) as? [[String : AnyObject]] {
                
                print(rootObject)
                
                for tweetObject in rootObject {
                    
                    if let text = tweetObject["text"] as? String,
                        id = tweetObject["id_str"] as? String,
                        user = tweetObject["user"] as? [String: AnyObject] {
                            
                     let isRetweet = self.isRetweet(tweetObject)
                                if isRetweet.0 == true {
                                    if let retweetObject = isRetweet.1 {
                                        if let retweetText = retweetObject["text"] as? String,
                                            retweetUser = retweetObject["user"] as? [String: AnyObject] {
                                                if let retweetUser = userFromData(retweetUser),
                                                    user = userFromData(user) {
                                                        let tweet = Tweet(text: text, reqText: retweetText, id: id, user: user, reqUser: retweetUser, isRetweet: true)
                                                        tweets.append(tweet)
                                                }
                                        }
                                    }
                                } else {
                            
                            
                                    let tweet = Tweet(text: text, id: id)
                            if let name = user["name"] as? String,
                                profileImageURL = user["profile_image_url"] as? String {
                                    
                                    tweet.user = User(name: name, profileImageURL: profileImageURL)
                                    
                            }
                            
                            tweets.append(tweet)
                            
                        }
                    }
                }
                
                return tweets
            }
                
        } catch _ {
            return nil
        }
        
        return nil
        
    }
    
    class func isRetweet(tweetObject: [String : AnyObject]) -> (Bool, [String : AnyObject]?) {
        if let retweetObject  = tweetObject["retweeted_status"] as? [String : AnyObject] {
            if let _ = retweetObject["text"] as? String, _ = retweetObject["user"] as? [String : AnyObject] {
                return (true, retweetObject)
            }
        }
        
        return (false, nil)
    }
    
    class func userFromData(user : [String : AnyObject]) -> User? {
        if let name = user["name"] as? String,
            profileImageURL = user["profile_image_url"] as? String {
                return User(name: name,  profileImageURL: profileImageURL)
        }
        
        return nil
    }
    
}

