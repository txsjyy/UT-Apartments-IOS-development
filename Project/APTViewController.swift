//
//  APTViewController.swift
//  Project
//
//  Created by Ricky on 11/28/22.
//

import UIKit
import MapKit

class APTViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var name_label: UILabel!
    var delegate1: UIViewController!
    @IBOutlet weak var apt_mapView: MKMapView!
    @IBOutlet weak var apt_imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name_label.text = apt_list[chosenidex]
        apt_imageView.image = UIImage(named: image_list[chosenidex])
        apt_mapView.delegate = self
        apt_mapView.showsUserLocation = false
        
        let center = CLLocationCoordinate2D(latitude: latitude_list[chosenidex], longitude: longitude_list[chosenidex])
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 2000, longitudinalMeters: 2000)
        
        apt_mapView.setRegion(region, animated: true)
        apt_mapView.mapType = .hybrid

        
    }
    

   
}
