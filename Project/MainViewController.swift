//
//  MainViewController.swift
//  Project
//
//  Created by Junyu Yao on 11/8/22.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    @IBAction func logoutPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
