//
//  User.swift
//  TwitterCF
//
//  Created by Regular User on 10/27/15.
//  Copyright © 2015 Lynn Kuhlman. All rights reserved.
//

import UIKit

class User {
    
    let name: String
    let profileImageURL: String
    var image: UIImage?
    
    init(name: String, profileImageURL: String){
        self.name = name
        self.profileImageURL = profileImageURL
    }
    
    
}
