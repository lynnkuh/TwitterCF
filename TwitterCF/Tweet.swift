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
    let username: String
    let profileImageURL: String
    
    init(text: String, id: String, username: String, profileImageURL: String){
        self.text = text
        self.id = id
        self.username = username
        self.profileImageURL = profileImageURL
    }
    
    
}
