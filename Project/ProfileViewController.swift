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

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var iconPicture: UIImageView!
    let picker = UIImagePickerController()
    //let myImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        let defaults = UserDefaults.standard
        
        Service.getUserInfo(onSuccess: {
            self.userNameLabel.text = " \(defaults.string(forKey: "userNameKey")!)"
        }) { (error) in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }
        
        darkMode.setOn(false, animated: false)
        darkMode.isOn = UserDefaults.standard.bool(forKey: "Switch")
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
    
    @IBOutlet weak var darkMode: UISwitch!
    
    @IBAction func darkModeSwitch(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "Switch")
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
        guard let imageData = chosenImage.pngData() else {
            return
        }
        let storage = Storage.storage().reference()
        let ref = storage.child("images/testfile.png")
        ref.putData(imageData) { _,error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            ref.downloadURL(){ url,error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print(urlString)
            }
        }
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
    
}
