//
//  FavouriteTableViewController.swift
//  Project Name: UT Apartment
//  Team 8: Junyu Yao, Mingda Li, Ruiqi Liu
//  Course: CS329E
//
//  Created by Junyu Yao on 11/30/22.
//

import UIKit
import CoreData

// store apartments
public var Favouritelist:[Apartment] = []

class FavouriteTableViewController: UITableViewController {

    // get data from core data
    func retrieveAPT() -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StoredApartment")
        var fetchedResults:[NSManagedObject]? = nil
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return(fetchedResults)!
    }

    // initial the tab views
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchedResults = retrieveAPT()
        if fetchedResults.count > 0 {
            for APT in fetchedResults {
                let storedAPT = Apartment(apt_name: APT.value(forKey: "aptName") as! String, apt_image: APT.value(forKey: "aptImage") as! String, apt_latitude: APT.value(forKey: "aptLa") as! Double, apt_longitude: APT.value(forKey: "aptLong") as! Double, apt_price: APT.value(forKey: "aptPrice") as! String)
                Favouritelist.append(storedAPT)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Favouritelist.count
    }
    
    //  cell for row at
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteTableViewCell
        let row = indexPath.row
        cell.favouriteImage.image = UIImage(named: Favouritelist[row].apt_image)
        cell.favouriteLabel.text = Favouritelist[row].apt_name
        cell.priceLabel.text = Favouritelist[row].apt_price
        return cell
    }
    
    //  swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Favouritelist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            removeAPTData(row: indexPath.row)
            let alert = Service.createAlertController(title: "Remove Favourite", message: "You have Removed \(apartment_list[chosenidex].apt_name) from your Favourite List")
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func removeAPTData(row:Int) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StoredApartment")
        var fetchedResults:[NSManagedObject]
        do {
            try fetchedResults = context.fetch(request) as! [NSManagedObject]
            context.delete(fetchedResults[row])
            saveContext()
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
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
