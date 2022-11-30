//
//  profileSettingViewController.swift
//  Project
//
//  Created by Junyu Yao on 11/28/22.
//

import UIKit
import Firebase

class profileSettingViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        Service.getUserInfo(onSuccess: {
            self.myLabel.text = "Welcome in \(defaults.string(forKey: "userNameKey")!)"
        }) { (error) in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
            
        }


    }
    


}
