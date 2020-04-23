//
//  MapViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 21/02/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseAuth
  
class MapViewController: UIViewController{
    var userRides:[UserRides] = []
    
    @IBOutlet weak var HostButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getRides()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshRides), name: Notification.Name("refresh"), object: nil)
        mapView.delegate = self
    }
    @objc func refreshRides (notification: NSNotification){
        getRides()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapToRight"{
            let targetVC = segue.destination as? RideEventViewController
            targetVC?.rideCorords = (sender as! CLLocationCoordinate2D)
        }
    }
}
extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = .purple
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//
//        if view.annotation is MKUserLocation {
//                     //return nil so map view draws "blue dot" for standard user location
//                     return
//            }
//        let annotation = view.annotation
//        if let coordinate = annotation?.coordinate {
//            performSegue(withIdentifier: "MapToRight", sender: coordinate)
//        }
//    }
//
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
         let annotation = view.annotation
         if let coordinate = annotation?.coordinate {
            performSegue(withIdentifier: "MapToRight", sender: coordinate)
        }
    }
}
//MARK: - Data request
extension MapViewController{
    func getRides(){
              let db = Firestore.firestore()
              db.collection("Events").getDocuments() { (snapshot, err) in
              if let err = err {
                  print("Error getting documents: \(err)")
              } else {
                  let documents = snapshot!.documents
                  try! documents.forEach{document in
                      let userRides: UserRides = try document.decoded()
                       print(userRides.rideName)
                       self.userRides.append(userRides)
                  }
                 for ride in 0..<self.userRides.count {
                     let mapPins = MKPointAnnotation()
                     let rides = self.userRides[ride]
                     mapPins.title = rides.rideName
                     let coordinate = CLLocationCoordinate2D(latitude: rides.rideYCordinate, longitude: rides.rideXCordinate)
                     mapPins.coordinate = coordinate
                     self.mapView.addAnnotation(mapPins)
                 }
             }
       }
    }
}

