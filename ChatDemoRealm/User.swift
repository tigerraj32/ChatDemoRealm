//
//  User.swift
//  ChatDemoRealm
//
//  Created by Javra Software on 19/01/2017.
//  Copyright © 2017 Javra Software. All rights reserved.
//

import RealmSwift
import Foundation

class User: Object {
  
    dynamic var name: String = ""
    dynamic var  password = ""
    dynamic var id: String = "1"
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

