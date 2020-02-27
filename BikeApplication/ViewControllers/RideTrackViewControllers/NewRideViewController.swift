//
//  NewRideViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 26/02/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit

class NewRideViewController: UIViewController {

      @IBOutlet weak var launchPromptStackView: UIStackView!
      @IBOutlet weak var dataStackView: UIStackView!
      @IBOutlet weak var startButton: UIButton!
      @IBOutlet weak var stopButton: UIButton!
      @IBOutlet weak var distanceLabel: UILabel!
      @IBOutlet weak var timeLabel: UILabel!
      @IBOutlet weak var paceLabel: UILabel!
      
      override func viewDidLoad() {
        super.viewDidLoad()
        dataStackView.isHidden = true
      }
      
      @IBAction func startTapped() {
      }
      
      @IBAction func stopTapped() {
      }
      
    }
