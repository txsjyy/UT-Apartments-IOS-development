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
        
        name_label.text = apartment_list[chosenidex].apt_name
        apt_imageView.image = UIImage(named: apartment_list[chosenidex].apt_image)
        apt_mapView.delegate = self
        apt_mapView.showsUserLocation = false
        
        let center = CLLocationCoordinate2D(latitude: apartment_list[chosenidex].apt_latitude, longitude: apartment_list[chosenidex].apt_longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
        
        apt_mapView.setRegion(region, animated: true)
        apt_mapView.mapType = .standard

        
    }
    

   
}

