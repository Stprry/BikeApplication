//
//  RideEventViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 24/03/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import MapKit
class RideEventViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var rideAttendees:[RideAttendees] = [] // make RideAtendees class/template for the ride atendee data

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // fill table view with users fetched from firebase
        return rideAttendees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "AtendeeCell", for: indexPath)
               let atendee = rideAttendees[indexPath.row]
               cell.textLabel!.text = atendee.firstName
               cell.detailTextLabel?.text = atendee.lastName
               return cell
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var rideNameLbl: UILabel!
    @IBOutlet weak var rideLeaderLbl: UILabel!
    @IBOutlet weak var rideTypeLbl: UILabel!
    @IBOutlet weak var rideAttendeesLbl: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signUpBtnTap(_ sender: Any) {
        // create firebase atendee add atendee to the ride attendee,
    }
    
}
