//
//  ProfileViewController.swift
//  Project Name: UT Apartment
//  Team 8: Junyu Yao, Mingda Li, Ruiqi Liu
//  Course: CS329E
//
//  Created by 李明达 on 11/29/22.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseStorage

// user profiles and settings

extension UIView {
    // allow user to change the font to bold
    func changeFontSize(){
        if let v = self as? UIButton {
            //v.titleLabel?.numberOfLines = 0
            let fontSize = v.titleLabel?.font.pointSize
            //v.titleLabel?.font = UIFont.systemFont(ofSize: fontSize!, weight: UIFont.Weight.bold)
        } else if let v = self as? UILabel {
            v.numberOfLines = 0
            let fontSize = v.font.pointSize
            v.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold)
            UILabel.appearance(whenContainedInInstancesOf: [UIViewController.self]).font = .boldSystemFont(ofSize: 17)
        } else if let v = self as? UITextField {
            let fontSize = v.font!.pointSize
            v.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold)
        } else {
            for v in subviews {
                v.changeFontSize()
            }
        }
    }
    
    // allow user to change the font back to regular
    func resetFontSize(){
        if let v = self as? UIButton {
            let fontSize = v.titleLabel?.font.pointSize
            //v.titleLabel?.font = UIFont.systemFont(ofSize: fontSize!, weight: UIFont.Weight.regular)
        } else if let v = self as? UILabel {
            let fontSize = v.font.pointSize
            v.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.regular)
            UILabel.appearance(whenContainedInInstancesOf: [UIViewController.self]).font = .systemFont(ofSize: 17)
        } else if let v = self as? UITextField {
            let fontSize = v.font!.pointSize
            v.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.regular)
        } else {
            for v in subviews {
                v.resetFontSize()
            }
        }
    }
}

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var musicButton: UIButton!
    var player: AVAudioPlayer?
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var fontButton: UISwitch!
    @IBOutlet weak var userNameLabel: UITextField!
    @IBOutlet weak var iconPicture: UIImageView!
    @IBOutlet weak var darkMode: UISwitch!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var budgetLabel: UITextField!
    let defaults = UserDefaults.standard
    let storage = Storage.storage()
    let picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        // set the avatar to a circle
        iconPicture.layer.cornerRadius = iconPicture.layer.frame.height/2
        iconPicture.clipsToBounds = true
        
        // get user profile from firebase
        Service.getUserInfo ( onSuccess: {
            self.userNameLabel.text = self.defaults.string(forKey: "userNameKey")!
            self.addressLabel.text = "\(self.defaults.string(forKey: "userAddressKey")!)"
            self.budgetLabel.text = "\(self.defaults.string(forKey: "userBudgetKey")!)"
            print(self.defaults.string(forKey: "userProfileImageKey")!)
            if self.defaults.string(forKey: "userProfileImageKey") != "none" {
                let urlString =  self.defaults.string(forKey: "userProfileImageKey")!
                let url = URL(string: urlString)
                let task = URLSession.shared.dataTask(with: url!) {data,_,error in
                    guard let data = data, error == nil else {
                        self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
                        return
                    }
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.iconPicture.image = image
                        self.iconPicture.layer.borderColor = UIColor.black.cgColor
                        self.iconPicture.layer.cornerRadius = self.iconPicture.frame.height/2
                        self.iconPicture.clipsToBounds = true
                    }
                }
                task.resume()
            }
        }) { (error) in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }
        
        
        // the dark mode and big font are off each time opening the app
        darkMode.setOn(false, animated: false)
        let appDelegate = UIApplication.shared.windows.first
        appDelegate?.overrideUserInterfaceStyle = .light
        fontButton.setOn(false, animated: false)
        UIApplication.shared.windows.first?.resetFontSize()
    }

    @IBAction func librarySelected(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    // allow user to switch the dark mode on and off
    @IBAction func darkModeSwitch(_ sender: UISwitch) {
        //UserDefaults.standard.set(sender.isOn, forKey: "Switch")
        if #available(iOS 15.0, *){
            let appDelegate = UIApplication.shared.windows.first
            if sender.isOn{
                appDelegate?.overrideUserInterfaceStyle = .dark
                return
            }
            appDelegate?.overrideUserInterfaceStyle = .light
            return
        }
    }
    
    // allow user to change avatar from
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as! UIImage
        iconPicture.image = chosenImage
        iconPicture.layer.borderColor = UIColor.black.cgColor
        iconPicture.layer.cornerRadius = iconPicture.frame.height/2
        iconPicture.clipsToBounds = true
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    // take photo from camera
    @IBAction func cameraSelected(_ sender: Any) {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            // use the rear camera
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                // we don't know
                AVCaptureDevice.requestAccess(for: .video) {
                    accessGranted in
                    guard accessGranted == true else { return }
                }
            case .authorized:
                // we have permission already
                break
            default:
                // we know we don't have access
                print("Access denied")
                return
            }
        
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        present(picker, animated: true)
            
        } else {
            // no rear camera is available
            let alertVC = UIAlertController(
                title: "No camera",
                message: "Sorry, this device has no rear camera",
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "OK",
                style: .default)
            alertVC.addAction(okAction)
            present(alertVC,animated:true)
        }
    }
//  play music button
    @IBAction func playMusic(_ sender: Any) {
        if let player = player, player.isPlaying{
            player.stop()
        }
        else {
            var ran = Int.random(in: 1..<6)
            let urlString = Bundle.main.path(forResource: "audio\(ran)", ofType: "mp3")
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                guard let urlString = urlString else {
                    return
                }
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                guard let player = player else {
                    return
                }
                player.play()
            }
            catch {
                print("someting went wrong")
            }
        }
    }
    
    //  font button
    @IBAction func fontButton(_ sender: UISwitch) {
        if sender.isOn{
            UIApplication.shared.windows.first?.changeFontSize()
            return
        }
        UIApplication.shared.windows.first?.resetFontSize()
        return
    }
    @IBAction func resetButton(_ sender: Any) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail:self.defaults.string(forKey: "userEmailKey")!) { (error) in
            if let error = error {
                let alert = Service.createAlertController(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                return
            }
            let alert = Service.createAlertController(title: "Hurray", message: "A password reset email has been sent!")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // allow user to log out
    @IBAction func logout(_ sender: Any) {
        let appDelegate = UIApplication.shared.windows.first
        appDelegate?.overrideUserInterfaceStyle = .light
        UIApplication.shared.windows.first?.resetFontSize()
        let auth = Auth.auth()
        do {
            try auth.signOut()
            Favouritelist = []
            self.dismiss(animated: true)
        } catch let signOutError {
            self.present(Service.createAlertController(title: "Error", message: signOutError.localizedDescription), animated: true)
        }
    }
    
    // allow user to delete account
    @IBAction func deleteButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.windows.first
        appDelegate?.overrideUserInterfaceStyle = .light
        UIApplication.shared.windows.first?.resetFontSize()
        let user = Auth.auth().currentUser
        user?.delete { error in
          if let error = error {
              self.present(Service.createAlertController(title: "Error", message: error.localizedDescription), animated: true)
          } else {
              Favouritelist = []
              self.dismiss(animated: true)
          }
        }
    }
    
    // allow user to save changes
    @IBAction func saveButton(_ sender: Any) {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        let chosenImage = iconPicture.image
        guard let imageData = chosenImage!.pngData() else {
            return
        }
        let reff = self.storage.reference().child("images/\(String(describing: defaults.string(forKey: "userNameKey")))/profileImage")
        reff.putData(imageData) { _,error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            reff.downloadURL(){ url,error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                ref.child("users").child(uid!).child("profileImage").setValue(urlString)
            }
        }
        ref.child("users").child(uid!).child("address").setValue(addressLabel.text)
        ref.child("users").child(uid!).child("budget").setValue(budgetLabel.text)
        ref.child("users").child(uid!).child("name").setValue(userNameLabel.text)
    }
    
    // hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
