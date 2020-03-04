//
//  RideHomeViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 26/02/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit

class RideHomeViewController: UIViewController {

    
    @IBOutlet weak var NewRideBtn: UIButton!
    @IBOutlet weak var PastRideBtn: UIButton!
    @IBOutlet weak var AchievementBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frontEndSetUp()
        // Do any additional setup after loading the view.
    }
    
    func frontEndSetUp(){
           Utilities.styleFilledButton(AchievementBtn)
           Utilities.styleFilledButton(PastRideBtn)
           Utilities.styleFilledButton(NewRideBtn)
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
