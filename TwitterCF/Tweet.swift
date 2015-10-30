//
//  Tweet.swift
//  TwitterCF
//
//  Created by Regular User on 10/26/15.
//  Copyright © 2015 Lynn Kuhlman. All rights reserved.
//

import Foundation

class Tweet {
    
    let text: String
    let id: String
    var user: User?
    
    let reqText: String?
    let reqUser: User?
    
    var isRetweet: Bool
    
    init(text: String, reqText: String? = nil, id: String, user: User? = nil, reqUser: User? = nil, isRetweet: Bool = false){
        self.text = text
        self.id = id
        self.user = user
        self.isRetweet = isRetweet
        self.reqUser = reqUser
        self.reqText = reqText
        
    }
    
    
}
