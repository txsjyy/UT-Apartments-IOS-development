//
//  DetailViewController.swift
//  Project
//
//  Created by 李明达 on 12/1/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var delegate: APTViewController!
    @IBOutlet weak var detailPicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailPicture.image = self.delegate.apt_imageView.image
        // Do any additional setup after loading the view.
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(detailPicture.image!, nil, nil, nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
