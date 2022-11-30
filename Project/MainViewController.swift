//
//  MainViewController.swift
//  Project
//
//  Created by Junyu Yao on 11/8/22.
//

import UIKit


public var apartment_list: [Apartment] = []





let signature1909 = Apartment(apt_name: "Signature 1909", apt_image: "signature1909", apt_latitude: 30.28354, apt_longitude: -97.74490, apt_price: "")



let torre = Apartment(apt_name: "Torre", apt_image: "signature1909", apt_latitude: 30.28368, apt_longitude: -97.74490, apt_price: "")








public var apt_list:[String] = ["Signature 1909", "Torre", "21 Rio", "Lark", "ion", "26 West", "Skyloft", "Moontower", "Inspire", "Crest at Pearl", "Pointe", "the Standard"]
public var image_list: [String] = ["signature1909", "torre", "21rio", "lark", "ion", "26west", "skyloft", "moontower", "inspire", "crest", "pointe", "standard"]

public var latitude_list: [Double] = [30.28354, 30.28368, 30.28449, 30.28425, 30.28413, 30.29130, 30.28632, 30.28552, 30.28538, 30.28316, 30.28307, 30.28703]

public var longitude_list: [Double] = [-97.74490, -97.74429, -97.74461, -97.74416, -97.74328, -97.74364, -97.74345, -97.74311, -97.74418, -97.74592, -97.74491, -97.74579]




public var chosenidex: Int = 0




public class Apartment {
    var apt_name: String
    var apt_image: String
    var apt_latitude: Double
    var apt_longitude: Double
    var apt_price: String
    
    init(apt_name:String, apt_image:String, apt_latitude:Double, apt_longitude:Double, apt_price: String) {
        self.apt_name = apt_name
        self.apt_image = apt_image
        self.apt_latitude = apt_latitude
        self.apt_longitude = apt_longitude
        self.apt_price = apt_price
    }
    
}




class MainViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
   
    
    
    
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "apt_segue",
           let destination = segue.destination as? APTViewController {
            destination.delegate1 = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenidex = indexPath.row
        self.performSegue(withIdentifier: "apt_segue", sender: nil)
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
