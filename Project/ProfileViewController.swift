//
//  ProfileViewController.swift
//  Project
//
//  Created by 李明达 on 11/29/22.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseStorage

extension UIView {
    func changeFontSize(){
        if let v = self as? UIButton {
            let fontSize = v.titleLabel?.font.pointSize
            v.titleLabel?.font = UIFont.systemFont(ofSize: fontSize!, weight: UIFont.Weight.black)
        } else if let v = self as? UILabel {
            let fontSize = v.font.pointSize
            v.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold)
        } else if let v = self as? UITextField {
            let fontSize = v.font!.pointSize
            v.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold)
        } else {
            for v in subviews {
                v.changeFontSize()
            }
        }
    }
    
    func resetFontSize(){
        if let v = self as? UIButton {
            let fontSize = v.titleLabel?.font.pointSize
            v.titleLabel?.font = UIFont.systemFont(ofSize: fontSize!, weight: UIFont.Weight.regular)
        } else if let v = self as? UILabel {
            let fontSize = v.font.pointSize
            v.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.regular)
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
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var iconPicture: UIImageView!
    @IBOutlet weak var darkMode: UISwitch!

    let picker = UIImagePickerController()
    //let myImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        iconPicture.layer.cornerRadius = 15
        iconPicture.clipsToBounds = true
        
        let storage = Storage.storage()
        let defaults = UserDefaults.standard
        
        Service.getUserInfo(onSuccess: {
            self.userNameLabel.text = " \(defaults.string(forKey: "userNameKey")!)"
            if defaults.string(forKey: "userProfileImageKey") != "none" {
                            let storageRef = storage.reference(forURL: defaults.string(forKey: "userProfileImageKey")!)
                        }
        }) { (error) in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }
        
        darkMode.setOn(false, animated: false)
        fontButton.setOn(false, animated: false)
       // darkMode.isOn = UserDefaults.standard.bool(forKey: "Switch")
    }
//
//    override var traitCollection: UITraitCollection {
//      UITraitCollection(traitsFrom: [super.traitCollection, UITraitCollection(userInterfaceStyle: .dark)])
//    }
//
    @IBAction func librarySelected(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as! UIImage
        iconPicture.image = chosenImage
//        guard let imageData = chosenImage.pngData() else {
//            return
//        }
//        let storage = Storage.storage().reference()
//        let ref = storage.child("images/testfile.png")
//        ref.putData(imageData) { _,error in
//            guard error == nil else {
//                print("Failed to upload")
//                return
//            }
//            ref.downloadURL(){ url,error in
//                guard let url = url, error == nil else {
//                    return
//                }
//                let urlString = url.absoluteString
//                let ref = Database.database().reference()
//                let uid = Auth.auth().currentUser?.uid
//                
//                ref.child("users").child(uid!).child("profileImage").setValue(urlString)
//            }
//        }
        viewWillAppear(false)
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
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
}
