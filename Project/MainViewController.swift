//
//  MainViewController.swift
//  Project
//
//  Created by Junyu Yao on 11/8/22.
//

import UIKit








let signature1909 = Apartment(apt_name: "Signature 1909", apt_image: "signature1909", apt_latitude: 30.28354, apt_longitude: -97.74490, apt_price: "$1,029 - $1,719")



let torre = Apartment(apt_name: "Torre", apt_image: "torre", apt_latitude: 30.28368, apt_longitude: -97.74429, apt_price: "$925 - $2,530")


let rio21 = Apartment(apt_name: "21 Rio", apt_image: "21rio", apt_latitude: 30.28449, apt_longitude: -97.74461, apt_price: "$859 - $2,079")

let lark = Apartment(apt_name: "Lark", apt_image: "lark", apt_latitude: 30.28425, apt_longitude: -97.74416, apt_price: "$799 - $1,309")

let ion = Apartment(apt_name: "ion", apt_image: "ion", apt_latitude: 30.28413, apt_longitude: -97.74328, apt_price: "$1,199 - $2,089")


let west26 = Apartment(apt_name: "26 West", apt_image: "26west", apt_latitude: 30.29130, apt_longitude: -97.74364, apt_price: "$1,069 - $1,874")

let skyloft = Apartment(apt_name: "Skyloft", apt_image: "skyloft", apt_latitude: 30.28632, apt_longitude: -97.74345, apt_price: "$1,099 - $2,165")


let moontower = Apartment(apt_name: "Moontower", apt_image: "moontower", apt_latitude: 30.28552, apt_longitude: -97.74311, apt_price: "$1,299 - $2,099")


let inspire = Apartment(apt_name: "Inspire", apt_image: "inspire", apt_latitude: 30.28538, apt_longitude: -97.74418, apt_price: "$700 - $1,900")


let crest = Apartment(apt_name: "Crest at Pearl", apt_image: "crest", apt_latitude: 30.28316, apt_longitude: -97.74592, apt_price: "$1,119 - $2,299")

let pointe = Apartment(apt_name: "Pointe", apt_image: "pointe", apt_latitude: 30.28307, apt_longitude: -97.74491, apt_price: "$900 - $2,000")

let standard = Apartment(apt_name: "Standard", apt_image: "standard", apt_latitude: 30.28703, apt_longitude: -97.74579, apt_price: "$905 - $1,810")

let axis = Apartment(apt_name: "Axis West", apt_image: "axis", apt_latitude: 30.29025, apt_longitude: -97.75044, apt_price: "$940 - $1,442")

let villas = Apartment(apt_name: "Villas on Rio", apt_image: "villas", apt_latitude: 30.28471, apt_longitude: -97.74463, apt_price: "$809 - $1,749")

let callaway = Apartment(apt_name: "Callaway House", apt_image: "callaway", apt_latitude: 30.28480, apt_longitude: -97.74342, apt_price: "$1,445 - $2,445")

public var apartment_list: [Apartment] = [signature1909, torre, rio21, lark, ion, west26, skyloft, moontower, inspire, crest, pointe, standard, axis, villas, callaway]


//public var apt_list:[String] = ["Signature 1909", "Torre", "21 Rio", "Lark", "ion", "26 West", "Skyloft", "Moontower", "Inspire", "Crest at Pearl", "Pointe", "the Standard"]
//public var image_list: [String] = ["signature1909", "torre", "21rio", "lark", "ion", "26west", "skyloft", "moontower", "inspire", "crest", "pointe", "standard"]


//public var latitude_list: [Double] = [30.28354, 30.28368, 30.28449, 30.28425, 30.28413, 30.29130, 30.28632, 30.28552, 30.28538, 30.28316, 30.28307, 30.28703]

//public var longitude_list: [Double] = [-97.74490, -97.74429, -97.74461, -97.74416, -97.74328, -97.74364, -97.74345, -97.74311, -97.74418, -97.74592, -97.74491, -97.74579]



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
        view.addSubview(collectionView)
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        collectionView?.addGestureRecognizer(gesture)
    }
    
    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        guard let collectionView = collectionView else {
            return
        }
        
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.imageView.image = UIImage(named: apartment_list[indexPath.row].apt_image)
        cell.label.text = apartment_list[indexPath.row].apt_name
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apartment_list.count
        
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
//        let lineSpacing: CGFloat = 5
//        let interItemSpacing: CGFloat = 5
        
        let width = (collectionView.frame.width - 15) / itemsPerRow
        let height = width
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    @IBAction func addNewApartment(_ sender: Any) {
    }
    
    func collectionView(_ collectionView: UIViewController, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = apartment_list.remove(at: sourceIndexPath.row)
        apartment_list.insert(item, at: destinationIndexPath.row)
    }
}
