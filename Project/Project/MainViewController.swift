//
//  MainViewController.swift
//  Project
//
//  Created by Junyu Yao on 11/8/22.
//

import UIKit


public var apt_list:[String] = ["Signature 1909", "Torre", "21 Rio"]
public var image_list: [String] = ["signature1909", "torre", "21rio"]
public var chosenidex: Int = 0


class MainViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    class Apartment {
        var apt_name: String
        var apt_image: UIImage
        var apt_rating_price: Int
        var apt_rating_amentities: Int
        var apt_rating_location: Int
        var apt_rating_leasingService: Int
        var apt_rating_overall: Int
        var apt_latitude: Double
        var apt_longitude: Double
        
        init(apt_name:String, apt_image:UIImage, apt_rating_price:Int, apt_rating_amentities:Int, apt_rating_location:Int, apt_rating_leasingService:Int, apt_rating_overall:Int, apt_latitude:Double, apt_longitude:Double) {
            self.apt_name = apt_name
            self.apt_image = apt_image
            self.apt_rating_price = apt_rating_price
            self.apt_rating_amentities = apt_rating_amentities
            self.apt_rating_location = apt_rating_location
            self.apt_rating_leasingService = apt_rating_leasingService
            self.apt_rating_overall = apt_rating_overall
            self.apt_latitude = apt_latitude
            self.apt_longitude = apt_longitude
        }
        
    }
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ItemCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.imageView.image = UIImage(named: image_list[indexPath.row])
        cell.label.text = apt_list[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apt_list.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenidex = indexPath.row
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let itemsPerRow: CGFloat = 3
        let lineSpacing: CGFloat = 5
        let interItemSpacing: CGFloat = 5
        
        let width = (collectionView.frame.width - (itemsPerRow - 1) * interItemSpacing) / itemsPerRow
        let height = width
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interItemSpacing
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    @IBAction func addNewApartment(_ sender: Any) {
    }
    
}
