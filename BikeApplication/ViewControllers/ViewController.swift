//
//  ViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 17/02/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var RegisterBtn: UIButton!
    
    @IBOutlet weak var LoginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        frontEndSetUp()
    }
    
    func frontEndSetUp(){
        Utilities.styleFilledButton(RegisterBtn)
        Utilities.styleHollowButton(LoginBtn)
    }
    
    
    @IBAction func LoginBtnTap(_ sender: Any) {
        
    }
    
    @IBAction func RegisterBtnTap(_ sender: Any) {
        
    }
}

