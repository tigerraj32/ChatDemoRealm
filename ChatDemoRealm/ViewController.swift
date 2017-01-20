//
//  ViewController.swift
//  ChatDemoRealm
//
//  Created by Javra Software on 19/01/2017.
//  Copyright © 2017 Javra Software. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    var user: User?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! UserListTableViewController
        destination.user = self.user
    }
    
    
    @IBAction func joinHandler(_ sender: Any) {
        if self.name.text?.characters.count == 0 || self.password.text?.characters.count == 0 {
            return
        }else {
            user = User(name: self.name.text!, password: self.password.text!)
            let users: Results<User> = DatabaseManager.shareInstance.realm.objects(User.self).filter("name = '\(user!.name!)'")
            if users.count == 0 {
                try! DatabaseManager.shareInstance.realm.write({
                    DatabaseManager.shareInstance.realm.add(user!)
                    
                })
            }else{
                self.user = users.first
                print("user already exist")
            }
            self.performSegue(withIdentifier: "segue.friendlist", sender: self)
            
        }
    }
    
    
    
    
}

