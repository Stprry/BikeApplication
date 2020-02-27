//
//  RideDetailsViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 26/02/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import MapKit


class RideDetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
      @IBOutlet weak var distanceLabel: UILabel!
      @IBOutlet weak var dateLabel: UILabel!
      @IBOutlet weak var timeLabel: UILabel!
      @IBOutlet weak var paceLabel: UILabel!
      
      override func viewDidLoad() {
        super.viewDidLoad()
      }
}

