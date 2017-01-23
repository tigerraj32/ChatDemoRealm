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
  
    dynamic var name: String? = nil
    dynamic var  password: String? = nil
    dynamic var id: Int = 0
    let heads = LinkingObjects(fromType: ChatHead.self, property: "users")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(name: String, password: String) {
        self.init()
        self.id = incrementID()
        self.name = name
        self.password = password
        
    }
    
     func incrementID() -> Int {
        print((ChatHead.self))
        
        let realm =  DatabaseManager.shareInstance.realm
        return (realm!.objects(User.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}

   


