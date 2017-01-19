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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinHandler(_ sender: Any) {
        if self.name.text?.characters.count == 0 || self.password.text?.characters.count == 0 {
            return
        }else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let user = User()
            user.name = self.name.text!
            user.password = self.password.text!
            
           try! appDelegate.realm.write({
            appDelegate.realm.add(user)
            
           })
            
           
            
        }
    }
    
    
    
    
}

