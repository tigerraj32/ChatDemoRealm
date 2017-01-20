//
//  Message.swift
//  ChatDemoRealm
//
//  Created by Javra Software on 20/01/2017.
//  Copyright © 2017 Javra Software. All rights reserved.
//


import RealmSwift
import Foundation


class Message: Object {
    dynamic var id: Int = 0
    dynamic var head: String? = nil
    dynamic var message: String? = nil
    dynamic var senderId: Int = 0
    dynamic var date: Date = Date()
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience  init(headId: String) {
        self.init()
        self.id = incrementID()
        self.head = headId
        
        
    }
    func incrementID() -> Int {
        print((ChatHead.self))
        
        let realm =  DatabaseManager.shareInstance.realm
        return (realm!.objects(Message.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }

    
}
