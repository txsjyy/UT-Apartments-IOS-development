//
//  APTViewController.swift
//  Project
//
//  Created by Ricky on 11/28/22.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class APTViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var name_label: UILabel!
    
    @IBOutlet weak var price_label: UILabel!
    @IBOutlet weak var distance_label: UILabel!
    @IBOutlet weak var apt_mapView: MKMapView!
    @IBOutlet weak var apt_imageView: UIImageView!
    
    var delegate1: UIViewController!
    
    let gdc_latitude: Double = 30.28624
    let gdc_longitude: Double = -97.73653
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue", let nextVC = segue.destination as? DetailViewController{
            nextVC.delegate = self
        }
    }
    
    @IBAction func picPressed(_ sender: Any) {
        //self.performSegue(withIdentifier: "detailSegue", sender: sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name_label.text = apartment_list[chosenidex].apt_name
        apt_imageView.image = UIImage(named: apartment_list[chosenidex].apt_image)
        apt_mapView.delegate = self
        apt_mapView.showsUserLocation = false
        
        
        let annontation = MKPointAnnotation()
        annontation.coordinate = CLLocationCoordinate2D(latitude: apartment_list[chosenidex].apt_latitude, longitude: apartment_list[chosenidex].apt_longitude)
        
        
        annontation.title = apartment_list[chosenidex].apt_name
        
        let region = MKCoordinateRegion(center: annontation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        
        apt_mapView.addAnnotation(annontation)
        
        apt_mapView.setRegion(region, animated: true)
        apt_mapView.mapType = .hybrid
        
        
        price_label.text = apartment_list[chosenidex].apt_price
        
        
        let gdc_location = CLLocation(latitude: gdc_latitude, longitude: gdc_longitude)
        let apt_location = CLLocation(latitude: apartment_list[chosenidex].apt_latitude, longitude: apartment_list[chosenidex].apt_longitude)
        
        
        let distanceInMeters = gdc_location.distance(from: apt_location)
        distance_label.text = String(format: "%.2f", distanceInMeters) + "m"
    }
    
    @IBAction func AddButton(_ sender: Any) {
        Favouritelist.append(apartment_list[chosenidex])
        self.storeAPT(newAPT: apartment_list[chosenidex])
        let alert = Service.createAlertController(title: "Add Favourite", message: "You have added \(apartment_list[chosenidex].apt_name) to your Favourite List")
        self.present(alert, animated: true, completion: nil)
        
    }
//  func for storing pizza in coredata
    func storeAPT(newAPT:Apartment) {
        let APT = NSEntityDescription.insertNewObject(forEntityName: "StoredApartment", into: context)
        APT.setValue(newAPT.apt_name, forKey: "aptName")
        APT.setValue(newAPT.apt_image, forKey: "aptImage")
        APT.setValue(newAPT.apt_longitude, forKey: "aptLong")
        APT.setValue(newAPT.apt_latitude, forKey: "aptLa")
        APT.setValue(newAPT.apt_price, forKey: "aptPrice")
//      commit changes
        saveContext()
    }
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
   
}
