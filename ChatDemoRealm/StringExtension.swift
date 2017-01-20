//
//  StringExtension.swift
//  ChatDemoRealm
//
//  Created by Javra Software on 20/01/2017.
//  Copyright © 2017 Javra Software. All rights reserved.
//

import Foundation

extension String {
    static  func chatHeadID() -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< 10 {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
}

