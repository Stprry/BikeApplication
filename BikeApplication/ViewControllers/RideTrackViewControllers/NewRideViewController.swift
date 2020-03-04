//
//  NewRideViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 26/02/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import CoreLocation

class NewRideViewController: UIViewController {

      @IBOutlet weak var launchPromptStackView: UIStackView!
      @IBOutlet weak var dataStackView: UIStackView!
      @IBOutlet weak var startButton: UIButton!
      @IBOutlet weak var stopButton: UIButton!
      @IBOutlet weak var distanceLabel: UILabel!
      @IBOutlet weak var timeLabel: UILabel!
      @IBOutlet weak var paceLabel: UILabel!
      
    private var ride: Ride?
    private let locationManager = LocationManager.shared
    private var seconds = 0
    private var timer: Timer?
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var locationList: [CLLocation] = []

    
    private func startRide() {
      launchPromptStackView.isHidden = true
      dataStackView.isHidden = false
      startButton.isHidden = true
      stopButton.isHidden = false
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
          self.eachSecond()
        }
        startLocationUpdates()

    }
      
    private func stopRide() {
      launchPromptStackView.isHidden = false
      dataStackView.isHidden = true
      startButton.isHidden = false
      stopButton.isHidden = true
      locationManager.stopUpdatingLocation()
    }

    
      override func viewDidLoad() {
        super.viewDidLoad()
        dataStackView.isHidden = true
        frontEndSetUp()
      }
    
    
    func frontEndSetUp(){
             Utilities.styleFilledButton(startButton)
         }
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      timer?.invalidate()
      locationManager.stopUpdatingLocation()
    }

    func eachSecond() {
      seconds += 1
      updateDisplay()
    }
    private func startLocationUpdates() {
      locationManager.delegate = self
      locationManager.activityType = .fitness
      locationManager.distanceFilter = 10
      locationManager.startUpdatingLocation()
    }
    private func saveRide() {
      let newRun = Ride(context: CoreDataStack.context)
      newRun.distance = distance.value
      newRun.duration = Int16(seconds)
      newRun.timestamp = Date()
      
      for location in locationList {
        let locationObject = Location(context: CoreDataStack.context)
        locationObject.timestamp = location.timestamp
        locationObject.latitude = location.coordinate.latitude
        locationObject.longitude = location.coordinate.longitude
        newRun.addToLocations(locationObject)
      }
      
      CoreDataStack.saveContext()
      
      ride = newRun
    }



    private func updateDisplay() {
      let formattedDistance = FormatDisplay.distance(distance)
      let formattedTime = FormatDisplay.time(seconds)
      let formattedPace = FormatDisplay.pace(distance: distance,
                                             seconds: seconds,
                                             outputUnit: UnitSpeed.minutesPerMile)
       
      distanceLabel.text = "Distance:  \(formattedDistance)"
      timeLabel.text = "Time:  \(formattedTime)"
      paceLabel.text = "Pace:  \(formattedPace)"
    }

      @IBAction func startTapped() {
        startRide()
      }
   
    
//      @IBAction func stopTapped() {
//        let rootSB = UIStoryboard(name: "RideTrack", bundle: Bundle.main)
//           guard let destinationVC = rootSB.instantiateViewController(identifier: "RideDetailsVC")as?
//           RideDetailsViewController else{
//           print("couldnt find VC")
//           return
//           }
//        let alertController = UIAlertController(title: "End Ride?",
//                                                message: "Do you wish to end your Ride?",
//                                                preferredStyle: .actionSheet)
//        alertController.addAction(UIAlertAction(title: "test nav", style: .cancel)
//        { _ in
//         self.navigationController?.pushViewController(destinationVC, animated: true)
//         })
//        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
//          self.stopRide()
//          self.saveRide()
//        })
//        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
//          self.stopRide()
//          _ = self.navigationController?.popToRootViewController(animated: true)
//        })
//
//        present(alertController, animated: true)
//
//      }
    @IBAction func stopTapped() {
          stopRide()
          let rideStoryboard = UIStoryboard(name: "RideTrack", bundle:Bundle.main)
          
          guard let destinationVC = rideStoryboard.instantiateViewController(identifier:Constants.Storyboards.rideDetails) as?
              RideDetailsViewController else{
                  print("couldn't find vc")
                  return
          }
          
          navigationController?.pushViewController(destinationVC, animated: true)
          // When User presses button let user decide wether to saveor cancel the ride
          let alertController = UIAlertController(title: "Finished Sending?",
                                                  message: "Do you wish to discard your ride?",
                                                  preferredStyle: .actionSheet)
          alertController.addAction(UIAlertAction(title: "Dissmiss", style: .cancel)
          { _ in
            self.stopRide()
            self.saveRide()
          })
          alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.stopRide()
            _ = self.navigationController?.popToRootViewController(animated: true)
          })
              
          present(alertController, animated: true)
        }
      
    }

extension NewRideViewController: CLLocationManagerDelegate {

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    for newLocation in locations {
      let howRecent = newLocation.timestamp.timeIntervalSinceNow
      guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }

      if let lastLocation = locationList.last {
        let delta = newLocation.distance(from: lastLocation)
        distance = distance + Measurement(value: delta, unit: UnitLength.meters)
      }

      locationList.append(newLocation)
    }
  }
}
