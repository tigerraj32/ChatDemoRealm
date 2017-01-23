//
//  UserListTableViewController.swift
//  ChatDemoRealm
//
//  Created by Javra Software on 20/01/2017.
//  Copyright © 2017 Javra Software. All rights reserved.
//

import UIKit
import RealmSwift

class UserListTableViewController: UITableViewController {
    var users:Results<User>?
    var user: User?
    var chatUser: User?
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
         self.navigationItem.hidesBackButton = true
        let predicate = NSPredicate(format: "name != %@",  (self.user?.name)!)
        self.users = DatabaseManager.shareInstance.realm.objects(User.self).filter(predicate)
        print(self.users)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutHandler(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.users!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell.friend.identifier", for: indexPath)
        let user = self.users?[indexPath.row]
        cell.textLabel?.text = user?.name
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chatUser = self.users?[indexPath.row]
        
        self.performSegue(withIdentifier: "segue.chat", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MessageViewViewController
        destination.user = self.user
        destination.friendUser = self.chatUser
        
        
    }
}
