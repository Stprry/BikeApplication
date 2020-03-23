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
    @IBOutlet weak var ViewButton: UIButton!
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
                }
      }
   }
}

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        for ride in 0..<self.userRides.count {
            let mapPins = MKPointAnnotation()
            let rides = self.userRides[ride]
            mapPins.title = rides.rideName
            let coordinate = CLLocationCoordinate2D(latitude: rides.rideYCordinate, longitude: rides.rideXCordinate)
            mapPins.coordinate = coordinate
          self.mapView.addAnnotation(mapPins)
        }

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
}

//for ride in 0..<self.userRides.count {
//                let mapPins = MKPointAnnotation()
//                               let rides = self.userRides[ride]
//                               mapPins.title = rides.rideName
//                               let coordinate = CLLocationCoordinate2D(latitude: rides.rideYCordinate, longitude: rides.rideXCordinate)
//                               mapPins.coordinate = coordinate
//                               self.mapView.addAnnotation(mapPins)
//                               print(self.userRides.count)
//           }
//extension MapViewController: MKMapViewDelegate{
//    func annotateMap() {
//           var parent : MapViewController
//
//           func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//               let identifier = "Placemark"
//
//               var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//
//               if annotationView == nil {
//                   annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                   annotationView?.canShowCallout = true
//                   annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//               }else{
//                   annotationView?.annotation = annotation
//               }
//               return annotationView
//           }
//
//        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//            print("\(String(describing: view.annotation?.title))")
//            }
//        }
//}





//extension MapViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//          let identifier = "Ride"
//
//          if annotation is UserRides {
//              if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
//                  annotationView.annotation = annotation
//                  return annotationView
//              } else {
//                  let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
//                  annotationView.isEnabled = true
//                  annotationView.canShowCallout = true
//
//                  let btn = UIButton(type: .detailDisclosure)
//                  annotationView.rightCalloutAccessoryView = btn
//                  return annotationView
//              }
//          }
//
//          return nil
//      }
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        let rides = view.annotation as! UserRides
//        let placeName = rides.rideName
//        let placeInfo = rides.rideLeader
//
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//    }
//}



//
//  func getRides(){
//           let db = Firestore.firestore()
//           db.collection("Events").getDocuments() { (snapshot, err) in
//           if let err = err {
//               print("Error getting documents: \(err)")
//           } else {
//               let documents = snapshot!.documents
//               try! documents.forEach{document in
//                   let userRides: UserRides = try document.decoded()
//                    print(userRides.rideName)
//                   self.userRides.append(userRides)
//               }
//            for ride in 0..<self.userRides.count {
//                let mapPins = MKPointAnnotation()
//                let rides = self.userRides[ride]
//                mapPins.title = rides.rideName
//                let coordinate = CLLocationCoordinate2D(latitude: rides.rideYCordinate, longitude: rides.rideXCordinate)
//                mapPins.coordinate = coordinate
//                self.mapView.addAnnotation(mapPins)
//                print(self.userRides.count)
//                }
//
//            }
//        }
//    }
//}
//
//func mapView(mapView: MKMapView!,
//    viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
//
//    if annotation is MKUserLocation {
//        //return nil so map view draws "blue dot" for standard user location
//        return nil
//    }
//
//    let reuseId = "pin"
//    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
//    if pinView == nil {
//        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//        pinView!.canShowCallout = true
//        pinView!.animatesDrop = true
//        pinView!.pinTintColor = .purple
//    }
//    else {
//        pinView!.annotation = annotation
//    }
//    return pinView
//}
