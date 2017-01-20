//
//  ChatHead.swift
//  ChatDemoRealm
//
//  Created by Javra Software on 20/01/2017.
//  Copyright © 2017 Javra Software. All rights reserved.
//

import RealmSwift
import Foundation


class ChatHead: Object {
    
    dynamic var id: Int = 0
    dynamic var head: String? = nil
    dynamic var userId: Int = 0
    
    
    
    
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
        return (realm!.objects(ChatHead.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
    
