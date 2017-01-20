//
//  MessageViewViewController.swift
//  ChatDemoRealm
//
//  Created by Javra Software on 20/01/2017.
//  Copyright © 2017 Javra Software. All rights reserved.
//

import UIKit
import RealmSwift

class MessageViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    
    var user: User?
    var friendUser: User?
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var input: UITextField!
    
    var headId: String?
    var conversation: Message?
    var allConversation: Results<Message>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = (self.user?.name!)! + ", " + (self.friendUser?.name!)!
        
        
        let predicate = NSPredicate(format: "userId=%d", (self.friendUser?.id)!)
        let heads = DatabaseManager.shareInstance.realm.objects(ChatHead.self).filter(predicate)
        
        if heads.count == 0 {
            self.headId = String.chatHeadID()
            try! DatabaseManager.shareInstance.realm.write({
                let chatHeadUser  = ChatHead(headId:  self.headId!)
                chatHeadUser.userId = (self.user?.id)!
                DatabaseManager.shareInstance.realm.add(chatHeadUser)
                
                let chatHeadFriend = ChatHead(headId:  self.headId!)
                chatHeadFriend.userId = (self.friendUser?.id)!
                DatabaseManager.shareInstance.realm.add(chatHeadFriend)
                
                
                
            })
        }else{
            print("chat head already exist")
            let head = heads.first
            self.headId = head?.head!
            
        }
        
        loadAllConversation()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendHandler(_ sender: Any) {
        print("message send")
        self.conversation = Message(headId: self.headId!)
        self.conversation?.message = self.input.text!
        self.conversation?.senderId = (self.user?.id)!
        try! DatabaseManager.shareInstance.realm.write({
            DatabaseManager.shareInstance.realm.add(self.conversation!)
            loadAllConversation()
        })
    }
    
    func loadAllConversation() -> Void {
        let predicate = NSPredicate(format: "head=%@", (self.headId!))
        self.allConversation = DatabaseManager.shareInstance.realm.objects(Message.self).filter(predicate)
        self.tableView.reloadData()
        
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.allConversation?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell.message", for: indexPath)
        let conv = self.allConversation?[indexPath.row]
        cell.textLabel?.text = conv?.message
        if conv?.senderId == self.user?.id {
            cell.textLabel?.textAlignment = NSTextAlignment.right
        }
        
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
