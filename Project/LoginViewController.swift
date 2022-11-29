//
//  LoginViewController.swift
//  Project: YaoJunyu-HW5
//  Eid : jy23984
//  Created by Junyu Yao on 10/17/22.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var SegCrtl: UISegmentedControl!
    @IBOutlet weak var SignButton: UIButton!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var forgotButton: UIButton!
    
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.isSecureTextEntry = true
        confirmField.isHidden = true
        confirmLabel.isHidden = true
        userNameLabel.isHidden = true
        nameField.isHidden = true
    }

    @IBAction func SegSwitch(_ sender: Any) {
        switch SegCrtl.selectedSegmentIndex{
        case 0 :
            SignButton.setTitle("Sign In", for: UIControl.State.normal)
            confirmField.isHidden = true
            confirmLabel.isHidden = true
            passwordField.isSecureTextEntry = true
            forgotButton.isHidden = false
            userNameLabel.isHidden = true
            nameField.isHidden = true
            
        case 1 :
            SignButton.setTitle("Sign Up", for: UIControl.State.normal)
            confirmField.isHidden = false
            confirmLabel.isHidden = false
            passwordField.isSecureTextEntry = false
            forgotButton.isHidden = true
            userNameLabel.isHidden = false
            nameField.isHidden = false
        default:
            SignButton.titleLabel!.text = "Sign In"
            confirmField.isHidden = true
            confirmLabel.isHidden = true
        }
    }
//  check login and perform segue
    @IBAction func SignInUpButton(_ sender: Any) {
        if SignButton.titleLabel!.text == "Sign In" {
            Auth.auth().signIn(withEmail: IDField.text!, password: passwordField.text!) {
                authResult, error in
                if let error = error as NSError? {
                    self.statusLabel.text = "\(error.localizedDescription)"
                } else {
                        self.statusLabel.text = "Sign In success"
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
//      create new user and login
        } else {
            if passwordField.text == confirmField.text{
                Auth.auth().createUser(withEmail: IDField.text!, password: passwordField.text!) {
                    authResult, error in
                    if let error = error as NSError? {
                        self.statusLabel.text = "\(error.localizedDescription)"
                    } else {
                        Service.uploadToDatabase(email: self.IDField.text!, name: self.nameField.text!) {
                            self.statusLabel.text = "Sign In success"
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                    }
                }
            }else {
                statusLabel.text = "Passwords don't match"
            }
        }
    }
    @IBAction func forgotPassButton_Tapped(_ sender: Any) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: IDField.text!) { (error) in
            if let error = error {
                let alert = Service.createAlertController(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                return
            }
            let alert = Service.createAlertController(title: "Hurray", message: "A password reset email has been sent!")
            self.present(alert, animated: true, completion: nil)
        }
    }
}

