//
//  Service.swift
//  Project
//
//  Created by Junyu Yao on 11/28/22.
//

import UIKit
import Firebase
import FirebaseStorage

class Service {
    static func uploadToDatabase(email: String, name: String, onSuccess: @escaping () -> Void) {
            let ref = Database.database().reference()
            let uid = Auth.auth().currentUser?.uid
            
            ref.child("users").child(uid!).setValue(["email" : email, "name" : name,"profileImage": "none","font":"none","address": "none","budget": "none"])
            onSuccess()
        }
        
    static func getUserInfo(onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref = Database.database().reference()
        let defaults = UserDefaults.standard
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        
        ref.child("users").child(uid).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let email = dictionary["email"] as! String
                let name = dictionary["name"] as! String
                let profileImage = dictionary["profileImage"] as! String
                let font = dictionary["font"] as! String
                let address = dictionary["address"] as! String
                let budget = dictionary["budget"] as! String
                
                defaults.set(email, forKey: "userEmailKey")
                defaults.set(name, forKey: "userNameKey")
                defaults.set(profileImage, forKey: "userProfileImageKey")
                defaults.set(font, forKey: "userFontKey")
                defaults.set(address, forKey: "userAddressKey")
                defaults.set(budget, forKey: "userBudgetKey")
                
                onSuccess()
            }
        }) { (error) in
            onError(error)
        }
    }
    
    static func createAlertController(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        
        return alert
    }
//    static func uploadImage(image: UIImage,onSuccess: @escaping () -> Void) {
//        // Create a storage reference from our storage service
//        let storageRef = Storage.storage().reference().child("myfiles/myfile")
//
//        storageRef.
//          // When the image has successfully uploaded, we get it's download URL
//            let downloadURL = snapshot.metadata?.downloadURL()?.absoluteString
//          // Write the download URL to the Realtime Database
//            let uid = Auth.auth().currentUser?.uid
//            let dbRef = Database.database().reference().child("users").child(uid!).setValue(["imageURL":downloadURL])
//        }
//

}
