//
//  ViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 15/03/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationsRef = FIRDatabase.database().reference(withPath: "locations")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationsRef.observe(.value, with: { snapshot in
            
            for item in snapshot.children {
               
                guard let locationData = item as? FIRDataSnapshot else { continue }
               
                let locationValue = locationData.value as! [String: Any]
                
                let location = CLLocationCoordinate2D(latitude: locationValue["lat"] as! Double, longitude: locationValue["lng"] as! Double)
                
                let name = locationValue["name"] as! String
                
                self.addAnnotation(at: location, name: name)
                
            }
        })
    }
    
    func addAnnotation(at location: CLLocationCoordinate2D, name: String) {
        
        // add that annotation to the map
        
            let annotation = MKPointAnnotation()
        
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
            mapView.addAnnotation(annotation)
        
        
        
    }
    

}


