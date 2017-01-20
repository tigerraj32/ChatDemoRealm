//
//  DatabaseManager.swift
//  ChatDemoRealm
//
//  Created by Javra Software on 20/01/2017.
//  Copyright © 2017 Javra Software. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    var notificationToken: NotificationToken!
    var realm: Realm!
    static let shareInstance: DatabaseManager = DatabaseManager()
}
