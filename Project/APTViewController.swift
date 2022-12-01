//
//  APTViewController.swift
//  Project
//
//  Created by Ricky on 11/28/22.
//

import UIKit
import MapKit
import CoreLocation

class APTViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var name_label: UILabel!
    
    @IBOutlet weak var price_label: UILabel!
    var delegate1: UIViewController!
    
    @IBOutlet weak var distance_label: UILabel!
    @IBOutlet weak var apt_mapView: MKMapView!
    @IBOutlet weak var apt_imageView: UIImageView!
    
    let gdc_latitude: Double = 30.28624
    let gdc_longitude: Double = -97.73653
    
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
        
        
        price_label.text = apartment_list[chosenidex].apt_price
        
        
        let gdc_location = CLLocation(latitude: gdc_latitude, longitude: gdc_longitude)
        let apt_location = CLLocation(latitude: apartment_list[chosenidex].apt_latitude, longitude: apartment_list[chosenidex].apt_longitude)
        
        
        let distanceInMeters = gdc_location.distance(from: apt_location)
        distance_label.text = String(format: "%.2f", distanceInMeters) + "m"
    }
    

   
}
