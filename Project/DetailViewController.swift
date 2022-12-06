//
//  DetailViewController.swift
//  Project Name: UT Apartment
//  Team 8: Junyu Yao, Mingda Li, Ruiqi Liu
//  Course: CS329E
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
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(detailPicture.image!, nil, nil, nil)
    }
    
}
