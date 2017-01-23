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
    
    var headId: String? = nil
    var conversation: Message?
    var allConversation: Results<Message>? = nil
    
    deinit {
        DatabaseManager.shareInstance.notificationToken.stop()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = (self.user?.name!)! + ", " + (self.friendUser?.name!)!
        
        print(self.user?.heads)

        for chead in (self.user?.heads)! {
            for u in  chead.users{
                if u == self.friendUser! {
                    print("we are lucky")
                    self.self.headId = chead.head
                    
                }else{
                    print("better luck next time")
                }
            }
        }
        
        if self.headId == nil {
            self.headId = String.chatHeadID()
            try! DatabaseManager.shareInstance.realm.write({
                let chatHeadUser  = ChatHead(headId:  self.headId!)
                chatHeadUser.users.append(self.user!)
                chatHeadUser.users.append(self.friendUser!)
                DatabaseManager.shareInstance.realm.add(chatHeadUser)
                
            })
            
        }
        loadAllConversation()
        DatabaseManager.shareInstance.notificationToken = DatabaseManager.shareInstance.realm.addNotificationBlock { note in
            //print(note)
            self.loadAllConversation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessageHandler(_ sender: Any) {
        print("message send")
        
        self.conversation = Message(headId: self.headId!)
        self.conversation?.message = self.input.text!
        self.conversation?.senderId = (self.user?.id)!
        try! DatabaseManager.shareInstance.realm.write({
            DatabaseManager.shareInstance.realm.add(self.conversation!)
            self.input.text = ""
            loadAllConversation()
        })
    }
    
    
    func loadAllConversation() -> Void {
        let predicate = NSPredicate(format: "head=%@", (self.headId!))
        self.allConversation = DatabaseManager.shareInstance.realm.objects(Message.self).filter(predicate)
        if (self.allConversation?.count)! > 0{
        self.tableView.reloadData()
        let lastIndex  = IndexPath(row: (self.allConversation?.count)! - 1, section: 0)
        self.tableView.scrollToRow(at: lastIndex , at: .bottom, animated: true)
        }
        
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.allConversation?.count)!
        //return 0
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
