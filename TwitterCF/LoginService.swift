//
//  LoginService.swift
//  TwitterCF
//
//  Created by Regular User on 10/28/15.
//  Copyright © 2015 Lynn Kuhlman. All rights reserved.
//

import Foundation
import Accounts


class LoginService {
    
    class func loginTwitter(completionHandler: (String?, ACAccount?) -> ()) {
        
        // Set up Account Store
        let accountStore = ACAccountStore()
        
        // Give Account Store an account type (Twitter)
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        // End of this is a closure
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: { (granted, error) -> Void in
            if let _ = error {
                completionHandler("ERROR: Request access to accounts returned an error.", nil); return
            }
            
            if granted {
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                    completionHandler(nil, account); return
                }
                
                // If no account was found
                completionHandler("ERROR: No twitter accounts were found on this device.", nil); return
            }
            
            // If user did not grant access to Account Store for Twitter accounts
            completionHandler("Error: This app requires access to the Twitter Accounts.", nil); return
        })
    }
}